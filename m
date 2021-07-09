Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF5C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 05:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B66C6144D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 05:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B66C6144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA406E980;
	Fri,  9 Jul 2021 05:45:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675BA6E980
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jul 2021 05:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czi2z4ETnB2sRXcSVrhxJgka+o1oqF3tYrIsHzGMoTRDbvYOdncYKJkxoXG0ZtJ9IY+fzbc/fXfnQKbiGHMPNO60yT/yicz2al5i+ycobjbHdLFeZ7xn+lUAqJG11B5voTSiUyIp8ZNPVCuosgGUzDY8Pfd0Ck4g8UX4Ju6ga3mGsTjeSZFPYrcsp47fdxs6JuOZedmta4OnSa6RpcXy8PR28kcds2vkWgk7SzmvcxbDVgAECpxlxTI3wNrvfDFOCT9eSD5BQEXjfQJZxxNmC3hh4NF2XrR7Qdm0gAZtOkAiEK45qtzy+kfwlXsXFW/CvIqUwzKU2b+O+oq1uTukoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX+IGTa5LBptTrqWq1rFu9m/hoCQ1ZprRiB1j1cNCyY=;
 b=QaR1jksvm15+TJP4GYVv4hkeqXQP4pclsS890u/+sjRkp0AP0sxBBm/8ERaCEZhWjvxNZMBfMaSxBmEgsgcKFvW1QxKZfBhlSIDU7K+/srXuXI6JD4zjuv08oJ17kT5Y6ax6dNsn/7azf4fc2hPzo2cj7wA5kRKiS7qT6iTyeOtVWTkju7APM6+qapgQZPgFRosQqAX5JxZTcaRNZtapF8IEzGKpUNKnYE1RmiWilGyfv49mQFPbIHotANppA8Tl85Cf1ibEswVN2RzIEZISG06slBALgQdmrSU75wmvDHbiTkhFZ0JvIykYxUcUy0GqcmISW1najItg+306Kg7MtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX+IGTa5LBptTrqWq1rFu9m/hoCQ1ZprRiB1j1cNCyY=;
 b=dg7CYToBY4pANfTiiq4mq2QNAuRpVvTdu8XW6uvBLNzAnVy2Wzkuo1LV76cMtRXR9AooKQCAdK2YYlVzV/i46KnnEECoX1TIOdEvYdnqoud5vK07UEfOsd4cc3QF2XgGCpqCYQV+Obz75mNth5WvRvNAUdMvzWjT9zQJKMj9cz4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR1201MB2517.namprd12.prod.outlook.com (10.172.121.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Fri, 9 Jul 2021 05:45:28 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::2cb6:690b:e6a0:d008%3]) with mapi id 15.20.4308.021; Fri, 9 Jul 2021
 05:45:28 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran
Thread-Topic: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on
 Aldebaran
Thread-Index: AQHXdDMDlOdp/joCFkyy1gi9UBWlQKs6ImXA
Date: Fri, 9 Jul 2021 05:45:27 +0000
Message-ID: <CY4PR12MB128747CFF7E872B1170AF60CF1189@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210708195333.322119-1-jinhuieric.huang@amd.com>
In-Reply-To: <20210708195333.322119-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-09T05:45:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=da3a8dac-4acf-4ae7-8d84-9a1d539bf45d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c56f2f4-cad2-4729-7b45-08d9429cc1aa
x-ms-traffictypediagnostic: CY4PR1201MB2517:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB2517F48DA7CA4E2D745B98A4F1189@CY4PR1201MB2517.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1fBBylFqDNvx+ZJoXpliL/yBWMQInklqSkzBHQjCENIDfs69nnfuyB1AVCgxkOAsE2YHn+PL1gEySkieRtTrzXQzzGY/WBzSwDgy1AFlsxRRCMJUr6jeXhvQrRQD5DNZVQ/pwVXROyP8KugjlKB/6/oa9FhKcWJOGAXABNidT6kEVZO8qWVRT4nWTG56SPnDzLufad0H3SIJ5gdSn3hTX6Q9Y+TfLpHgMk4mpfeMkr/HU3iM8A+Jsvg98n7xyKrPD+Eg7dWUvHzdExijMR5uhi/hKyetWpeHUXSB8+guijWrirkF1ATaWah+aajrA1hIyWf/2TAH/g0WeiR4tdhmvF7Blnk2vmeUMJ9lXdmN7yx7eePawCHfBAdAHj+vbh4eE6L7cMO2TGqQtjFutt7CKQ3JwkLm17WsMlYrZncQMwblzjZHamNffDqQzxXt7OpqAn3U1wUpfr5GWeFVzjPtmhDYvJmzvSobcxcWCx3RXFoIpI8EXbsWtI7/LfiLdCZ159PeFbmIFMBnu+jmOOh+a74KgjJr5vt44nO+4ViYU6egag9BRx3UL26SanzfomZzoCwx8kfezetiw83IMZ6B45Hjszop599RgyE046DLE/AksCATewzoNSzBNwidDFt+5tfIzityu0Z5n2e7sVfbaxxgye6TI2Mn+s4ZrGITdBvpOoQT/bSjE2hE6M5qkv6Nu+mtoaxssL5pG9pmtLaQA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(71200400001)(186003)(8676002)(64756008)(66476007)(66556008)(52536014)(76116006)(6506007)(38100700002)(122000001)(7696005)(33656002)(4326008)(66446008)(83380400001)(8936002)(2906002)(316002)(26005)(66946007)(55016002)(110136005)(54906003)(9686003)(45080400002)(86362001)(5660300002)(478600001)(966005)(53546011)(16393002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4OhDgc1gKg/rjd52RGqKiWrhMlzZ6bAnixM2dCtWVpv3kaC7gAQvYNZWWLZa?=
 =?us-ascii?Q?Fj7pHGKM+8hXwOBRaxQemsy3C3jvip6aPzbm1FJjqrGmYDFp5riHegpyemFt?=
 =?us-ascii?Q?k9IR2m4LlgJ48NpmWajKQuTTvmiPPX8gcsha13P8fJWTZ+mb/vppXJTek3eG?=
 =?us-ascii?Q?ZxCF8byg41Ktqa7yMatW2Tn7cgoQG/n30w+YlA4lQgaysfBkhe5sRtE7rLm0?=
 =?us-ascii?Q?yvsp2eyeafwBCiIs8h38CjapGWEMxJfpaYCPNFVLPuNEiz5yeunF2MQyEpDg?=
 =?us-ascii?Q?FaoOWjRVbn1gztvaE18lf3SMbJHLN5f71KuvZChWYXsqj4FlFBXlTtCVJDrQ?=
 =?us-ascii?Q?of4bGIf32YQ65QFxOV2+MGPIiRNHz8kfFjg2tDlAit9FES89wXTPACYVoc5h?=
 =?us-ascii?Q?qoSJEpDv5n28i+MbpfkLSCG2gxDLVmJoFpxs9Kmgzi6dy7yK4zR8sXvPmd5Y?=
 =?us-ascii?Q?BMkQCInh8dLUuBjjbOUvvs4mXNfUVDW23bzNynCnoF3Abeii8gSGnVS6yyJQ?=
 =?us-ascii?Q?DlmlmzYLw8O1UgRSfQXsaG/uRcp9OJGtik5KXwfDCSIUbWOI+PVC6WEa64Pv?=
 =?us-ascii?Q?xqfLrbfEiBc2ygTA4MhErzDE5+v9PfdgqbnWSI26EbncrdYvm8XI9VpZdMYa?=
 =?us-ascii?Q?luWVB1T1wY/THK1IG17kQ5khbjpqFRnwJAwb0n9HCLoTzlbpozbiY+nvz0jG?=
 =?us-ascii?Q?oc/axZbRI6visntc1yw0/3htNqOth/lAkfnFgbxQMZFud8MdXe3QiWpA0ThM?=
 =?us-ascii?Q?gWG7/T1+IW6/jkco8T7gDYW1ydkSssDWJwDFp9LzZO1nKoONunBxgaRkFqiG?=
 =?us-ascii?Q?4aUM2pDxu8JqITkUAMBEE8wjxwH+NP14mmHRBM62EMx3JvOrW/WzwI4DH6fl?=
 =?us-ascii?Q?2387wmXRAtIplFkc41sVHXONHAWtGAXiqfThEY+kbWRqUbdy0sJOWtc4gJy2?=
 =?us-ascii?Q?UVlqzGKIVPs5Z6CHmGGCdNRwID7zZGrCwRsYPzmDeUAke+sxkGvlsEPzSF45?=
 =?us-ascii?Q?RBKUGwhAHu2EXimf4Ms+QzCfnReQh6UN1sLOfWEtX317GKZ1FLyDEMpxmzWY?=
 =?us-ascii?Q?TqoY/4VB4tddRCY1qel+zdhqsxhW2kK4zFdw6Dat7W/KfpPjc4WNpHsiFTgm?=
 =?us-ascii?Q?Nw3Vv86V1LHICcph0rys2Evo27QVXgEKGL4wdXGDj5Tq2TDdF5t6vZWiuAPy?=
 =?us-ascii?Q?sA9F5fSzrUaFMcD8inmQr5do4YUy0inaU+EtO9FBtiUuBgCaJ1s4hoy91sIu?=
 =?us-ascii?Q?KlqCF+K+IYpjteo+CmmsG16emyE2auMycrjJivXzwnAhYXJ3aJElZlZYxc+7?=
 =?us-ascii?Q?MwKh8qf1cewPmBu/M9w9EZoI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56f2f4-cad2-4729-7b45-08d9429cc1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 05:45:27.9793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pe8RMgmqgEEdnLf752m46sigUQOmR9VvzOp866Rjxe+03GXbd2+19oo2CCxDGpdomg4Hw9UUd92nuYSvqgKsEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2517
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Original patch will cause regressions on Aldebaran as well, so this workaround is still invalid.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Eric Huang
Sent: Friday, July 9, 2021 3:54 AM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Only apply heavy-weight TLB flush on Aldebaran

It is to workaround HW bug on other Asics and based on reverting two commits:
  drm/amdkfd: Add heavy-weight TLB flush after unmapping
  drm/amdkfd: Add memory sync before TLB flush on unmap

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 37 +++++++++++++-----------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index ebb4872c5a9d..5f2655cf0162 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1773,26 +1773,29 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 	mutex_unlock(&p->mutex);
 
-	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
-	if (err) {
-		pr_debug("Sync memory failed, wait interrupted by user signal\n");
-		goto sync_memory_failed;
-	}
+	if (dev->device_info->asic_family == CHIP_ALDEBARAN) {
+		err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd,
+				(struct kgd_mem *) mem, true);
 
-	/* Flush TLBs after waiting for the page table updates to complete */
-	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
-		if (WARN_ON_ONCE(!peer_pdd))
-			continue;
-		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
-			amdgpu_read_unlock(peer->ddev);
+		if (err) {
+			pr_debug("Sync memory failed, wait interrupted by user signal\n");
+			goto sync_memory_failed;
 		}
-	}
 
+		/* Flush TLBs after waiting for the page table updates to complete */
+		for (i = 0; i < args->n_devices; i++) {
+			peer = kfd_device_by_id(devices_arr[i]);
+			if (WARN_ON_ONCE(!peer))
+				continue;
+			peer_pdd = kfd_get_process_device_data(peer, p);
+			if (WARN_ON_ONCE(!peer_pdd))
+				continue;
+			if (!amdgpu_read_lock(peer->ddev, true)) {
+				kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
+				amdgpu_read_unlock(peer->ddev);
+			}
+		}
+	}
 	kfree(devices_arr);
 
 	return 0;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C69113cf367eb450a8f8808d9424a23fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637613708477013366%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=0ESYvG5kCSJaFT9dR4jW5VacL8x7TghGw1aKWTRa9R4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
