Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03650C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 20:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62E22064B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hNdwkB3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62E22064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6306E8FD;
	Tue,  1 Sep 2020 20:35:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8226E8FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 20:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnBCgLXeHjJBLSnkxMCnIEFJt5E5YnSOhfLs9esUSohDfMj3ia6uKjZ9xmeRnH1fCwkEnIONG4SEDEPIEBIfW9zK1SiLAu6Dy5TR96HWA7TdVW04UGuVrkUIO8wMjuuATR6R5o87BoJ25tGBsQE43eCcaNfm3RyfYyOM1VMhqgg/6Fekx7gFqFs9EXK6PXzcgnzpo/+O3CKNS++8arObZ6/D2NYSNd5s5gktPw4pdfrUwDu6F5dzviHm6tB4ayNqyq8PvqjQMxdeP1v0Fn2TlnzYjC+RrUo97bwQOr3QEhbHhPD04C1hybpifPuCKxrPcyJ+/O3hbamQDYz2hj1I8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6YpCx4eiH5/rOhCBbM9vYHOe9zAN9CRRT/rKSZ1MM0=;
 b=kTWuzn9ovZ/UOM5DIRORFQ7P4Piwb5HDUluUnQjaW+rbXd88roqbagd4afdDO+vckepo8FA2JAgEDZGI8XJx0KxVDWias1s+1XmzIOEvTVV0/p7Mhb3N/rhpEk/V9zPKqCXISX3jUrYtjtyFzIuGW96jCYYJ2wcHStrIiVq6Ll3vh/6VbnmNMrXIPyb0Gl8kdx+X1Pexm05MrTixosZuZ8sD8xEr+kZKsrmAVEjqt33TT4Us7fqO1lBVtun+gHsxqomQG4sZ1szYqcmmkng0Oq9n7y47sSOLmTBx10+zmGJL9Ir7l/ykUKxD//UgcsXB0raf8/fexSqa16gKbSiBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6YpCx4eiH5/rOhCBbM9vYHOe9zAN9CRRT/rKSZ1MM0=;
 b=hNdwkB3nretNQKHHfYdBLyAkX5cUTge5ujBXGhQgKxCBn0/CPfPliFFujx39C6QVqUIe+asX9uHjbivvfL6B5GGsXdfz/gZAljrqOl1hWY16x2hBZTSHUFnvUo2X7ZXhzhca9tRXVFb3TnJ45oyto0fsJSJAGW62ZcIpQNR9cfQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Tue, 1 Sep
 2020 20:35:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 20:35:34 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix a redundant kfree
To: Alex Deucher <alexdeucher@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
 Daniel Vetter <daniel.vetter@ffwll.ch>
References: <SN1PR12MB25588CE66B9F67BBAED67655872E0@SN1PR12MB2558.namprd12.prod.outlook.com>
 <CADnq5_NPNR2OAekTndORuKpzTP13Tx_KMNcnKLG8jB8O9fw8og@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <93da33fe-3157-3267-098d-4c4726b8cff3@amd.com>
Date: Tue, 1 Sep 2020 16:35:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
In-Reply-To: <CADnq5_NPNR2OAekTndORuKpzTP13Tx_KMNcnKLG8jB8O9fw8og@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Tue, 1 Sep 2020 20:35:33 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 955acc76-72e1-49d4-0c61-08d84eb69375
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298675F6EABE34B6C5C8057F992E0@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaorBkCSQcr2cbUGY+0PfvWWxxjuyvLN/9dMwratmGAZJ4TNnS9PvmTP7Y/rBNH7Hp6Z6Cboax8nEuNfJ9BgjplOSHTYGaoMjc5tRp857wW1iToUpJCQ6YNSL6a+4LuTc/IoC6HlL+AUdjbVusFV9mB77KY9Gj9e/66+RmekY2O3bT/0ptmfqFjvLQUIdd/iQ+Gh6ORlT5bXQarr9whU9exQys9GSrMsilSVuzWkhB+vzulzmyy0l7BmQ2mg5oVyC3v5TiOLUUW3mTygWKnn/G4Wotg/30FVrBbcC7ECuoo5/E8FGhrQjG1v3Y/pIJn8iu7zhUqTsA+ytzq/Q4onsKNqSwMqvNWGakM1In8MTS2iN/HSO1nFGNh5S8Kx+P7ryNx5QTtANc5AAERu9zWW6jqlSksIjdLtlbTlqwDaanM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(83380400001)(36756003)(26005)(8676002)(8936002)(2906002)(5660300002)(44832011)(86362001)(186003)(31686004)(66556008)(4326008)(110136005)(2616005)(478600001)(31696002)(16576012)(316002)(54906003)(966005)(45080400002)(956004)(66946007)(53546011)(66476007)(52116002)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5FWTe6dfo2NNW49gpBk3H9cX5rihC31vFaZQGcgyFLBunoQ+sgimSRKAXgeCchS3WtmXtw7X+XimL/tpyUF5E+DKVWaE05d1ECQF3fmeQdMiuPmhDwvxIOPPL8Ag9aE67mkzVZeRivE2xKiAnNQk6sMZoFA2FCwr+Tr5cWdaQZh4pvRTweUHpLfNkHXII49c2AOGpTWaiOVL/uuhp/mjLGyFwkezr3cRoyFUXOfVcCeQj9VIPweBZeFL6S5ZoNybkctZLaZ63PQ3zLg4byukQOrsQfkt3D6QdKS6eRLyK/VjmhOuohvHyp8Y0pS1Z+tqrlEsoMee5eHa5BoERHHnyLhx1SkEFg4dgCvKJcdgbdOnPLr4GVugeRhqflLNVsb/YNYZeFQiSMnCZNNb+i8gvUCLWwuBCGvAHhXJ2WTZcbMll3ry4pBCi/inyMtcndDlFnYJhEKGvbmBT7Gb4oec6aBczAtCP+JcmaDGYa/VMbOBmpKaImYPmkZhfw+4SYJk8vOgNzWsuIBgxzosTdU+VDMB6tpbe7EHHM/oCMChEihcwl/HQjXipIynttDFHpQUEVayD2XFhyMHFJh/LAj4KJkhpZRR9U5quVTEOYtT0ZD8ScKBzYHconK/1tmkSATI/QUyqHCm8szrof9X6RPDZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955acc76-72e1-49d4-0c61-08d84eb69375
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 20:35:34.0479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWKIc/HEm/hlk6X404p5dcs4zTQrOrgLwtU/YMPN8sq6M5RAeaYIuhFAVek0cteP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-01 10:12 a.m., Alex Deucher wrote:
> On Tue, Sep 1, 2020 at 3:46 AM Pan, Xinhui <Xinhui.Pan@amd.com> wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> drm_dev_alloc() alloc *dev* and set managed.final_kfree to dev to free
>> itself.
>> Now from commit 5cdd68498918("drm/amdgpu: Embed drm_device into
>> amdgpu_device (v3)") we alloc *adev* and ddev is just a member of it.
>> So drm_dev_release try to free a wrong pointer then.
>>
>> Also driver's release trys to free adev, but drm_dev_release will
>> access dev after call drvier's release.
>>
>> To fix it, remove driver's release and set managed.final_kfree to adev.
> 
> I've got to admit, the documentation around drm_dev_init is hard to
> follow.  We aren't really using the drmm stuff, but you have to use
> drmm_add_final_kfree to avoid a warning.  The logic seems to make
> sense though.
> Acked-by: Alex Deucher <alexancer.deucher@amd.com>

The logic in patch 3/3 uses the kref infrastructure
as described in drm_drv.c's comment on what the DRM
usage is, i.e. taking advantage of the kref infrastructure.

In amdgpu_pci_probe() we call drm_dev_init() which takes
a ref of 1 on the kref in the DRM device structure,
and from then on, only when the kref transitions
from non-zero to 0, do we free the container of
DRM device, and this is beautifully shown in the
kernel stack below (please take a look at the kernel
stack below).

Using a kref is very powerful as it is implicit:
when the kref transitions from non-zero to 0,
then call the release method.

Furthermore, we own the release method, and we
like that, as it is pure, as well as,
there may be more things we'd like to do in the future
before we free the amdgpu device: maybe free memory we're
using specifically for that PCI device, maybe write
some registers, maybe notify someone or something, etc.

On another note, adding "drmm_add_final_kfree()" in the middle
of amdgpu_pci_probe() seems hackish--it's neither part
of drm_dev_init() nor of drm_dev_register(). We really
don't need it, since we rely on the kref infrastructure
to tell us when to free the device, and if you'd look
at the beautiful stack below, it knows exactly when that is,
i.e. when to free it.

The correct thing to do this is to
_leave the amdgpu_driver_release()_ alone,
remove "drmm_add_final_kfree()" and qualify
the WARN_ON() in drm_dev_register() by
the existence of drm_driver.release() (i.e. non-NULL).

I'll submit a sequence of patches to fix this right.

Regards,
Luben

> 
>>
>> [   36.269348] BUG: unable to handle page fault for address: ffffa0c279940028
>> [   36.276841] #PF: supervisor read access in kernel mode
>> [   36.282434] #PF: error_code(0x0000) - not-present page
>> [   36.288053] PGD 676601067 P4D 676601067 PUD 86a414067 PMD 86a247067 PTE 800ffff8066bf060
>> [   36.296868] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
>> [   36.302409] CPU: 4 PID: 1375 Comm: bash Tainted: G           O      5.9.0-rc2+ #46
>> [   36.310670] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
>> [   36.320725] RIP: 0010:drm_managed_release+0x25/0x110 [drm]
>> [   36.326741] Code: 80 00 00 00 00 0f 1f 44 00 00 55 48 c7 c2 5a 9f 41 c0 be 00 02 00 00 48 89 e5 41 57 41 56 41 55 41 54 49 89 fc 53 48 83 ec 08 <48> 8b 7f 18 e8 c2 10 ff ff 4d 8b 74 24 20 49 8d 44 24 5
>> [   36.347217] RSP: 0018:ffffb9424141fce0 EFLAGS: 00010282
>> [   36.352931] RAX: 0000000000000006 RBX: ffffa0c279940010 RCX: 0000000000000006
>> [   36.360718] RDX: ffffffffc0419f5a RSI: 0000000000000200 RDI: ffffa0c279940010
>> [   36.368503] RBP: ffffb9424141fd10 R08: 0000000000000001 R09: 0000000000000001
>> [   36.376304] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0c279940010
>> [   36.384070] R13: ffffffffc0e2a000 R14: ffffa0c26924e220 R15: fffffffffffffff2
>> [   36.391845] FS:  00007fc4a277b740(0000) GS:ffffa0c288e00000(0000) knlGS:0000000000000000
>> [   36.400669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   36.406937] CR2: ffffa0c279940028 CR3: 0000000792304006 CR4: 00000000003706e0
>> [   36.414732] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   36.422550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   36.430354] Call Trace:
>> [   36.433044]  drm_dev_put.part.0+0x40/0x60 [drm]
>> [   36.438017]  drm_dev_put+0x13/0x20 [drm]
>> [   36.442398]  amdgpu_pci_remove+0x56/0x60 [amdgpu]
>> [   36.447528]  pci_device_remove+0x3e/0xb0
>> [   36.451807]  device_release_driver_internal+0xff/0x1d0
>> [   36.457416]  device_release_driver+0x12/0x20
>> [   36.462094]  pci_stop_bus_device+0x70/0xa0
>> [   36.466588]  pci_stop_and_remove_bus_device_locked+0x1b/0x30
>> [   36.472786]  remove_store+0x7b/0x90
>> [   36.476614]  dev_attr_store+0x17/0x30
>> [   36.480646]  sysfs_kf_write+0x4b/0x60
>> [   36.484655]  kernfs_fop_write+0xe8/0x1d0
>> [   36.488952]  vfs_write+0xf5/0x230
>> [   36.492562]  ksys_write+0x70/0xf0
>> [   36.496206]  __x64_sys_write+0x1a/0x20
>> [   36.500292]  do_syscall_64+0x38/0x90
>> [   36.504219]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 +---------
>>  1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index c12e9acd421d..52fc0c6c8538 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1165,7 +1165,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>  if (ret)
>>  goto err_free;
>>
>> -drmm_add_final_kfree(ddev, ddev);
>> +drmm_add_final_kfree(ddev, adev);
>>
>>  if (!supports_atomic)
>>  ddev->driver_features &= ~DRIVER_ATOMIC;
>> @@ -1221,13 +1221,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>  drm_dev_put(dev);
>>  }
>>
>> -static void amdgpu_driver_release(struct drm_device *ddev)
>> -{
>> -struct amdgpu_device *adev = drm_to_adev(ddev);
>> -
>> -kfree(adev);
>> -}
>> -
>>  static void
>>  amdgpu_pci_shutdown(struct pci_dev *pdev)
>>  {
>> @@ -1522,7 +1515,6 @@ static struct drm_driver kms_driver = {
>>  .open = amdgpu_driver_open_kms,
>>  .postclose = amdgpu_driver_postclose_kms,
>>  .lastclose = amdgpu_driver_lastclose_kms,
>> -.release   = amdgpu_driver_release,
>>  .irq_handler = amdgpu_irq_handler,
>>  .ioctls = amdgpu_ioctls_kms,
>>  .gem_free_object_unlocked = amdgpu_gem_object_free,
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CLuben.Tuikov%40amd.com%7C5233b0caaac449417a7208d84e810de0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637345663485193534&amp;sdata=A%2FzJpoQmUhGBGts5mQfp%2BlVu1FL5NVbe5qfRelb2Og8%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
