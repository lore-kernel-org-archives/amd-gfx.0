Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F3C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDE420872
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p8Cup9P+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDE420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C7E6E827;
	Fri, 28 Aug 2020 20:29:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F546E827
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 20:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAgNB5S4m5/YCMPKR629ssmC6GzPBx7rNFCdOo1Se4uiORzYBDKW/aTdxLX9X5h8W36kEJUgUCqJfEE4ofsohqgXthVQRg9BoERlxHhSb+U4xQmErjClrYzXZhWB3L40PBjz0/dbGMBU+Dm575IcLizDSaLU8PjjlumouDZ0s3G5VNdpu0XsUarJfY3pLbaOBFRaas1KKwPV+t2lK9gL9BxAZ64paofQwQ9My1npPCQtc9UKT8P+QJ+s8I9nkunEhojqgiNDY5vb2e1hHg85G7s879gd4wHacfdON3JVonVcidyGlGtbCels84cQLSuWrdMNjIoGvokaqopzjH+kEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH89BxRhCKhpFNeYxXaLVuCICWiTicUuoIDQ/9bVRwQ=;
 b=OuaASKQ2kGFvENWYluufISkpw+ZeypKm/xDLnpkC9gso49ZT4kTEYWtVcrBb9vUYhDVVTAHIbMOBp4npPB33NjwLnA3eZlX/MD8gVFvhiiZva/D01/1T+bZyabAWzbx5NO3TGf+sov6AS6y9CFdCC4o2SswfibQGNm5j3s6bxtfBDwfWOTaHdI0MZcmLzvzcnrjQwEr76BFoUAgore+9DXs+Gq0OZZglcyQjF2kmhUmWbA4NMh5yulG6Wrg0bvq33mp5ErJD2+HUVTxOiNkWzElstD3MAtmxcE2K6pX+eZxRjY8/VjnCpol8fFxid9MLq6t2kNaJMJWk38Pg/HWR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH89BxRhCKhpFNeYxXaLVuCICWiTicUuoIDQ/9bVRwQ=;
 b=p8Cup9P+YfM4N12SNvcPD91TulX/RpZ09Nod7fTp0QVvI7RAb5JT5s2EPnzaLn4WS/WEWGSO0qTtq9eN9+mhfIILBpnCGbXBFPeIOuzQRL7s4pd62fmFkUQ/AnaOyduXKUs7imPT/XXv2/D6zGSAj+kNMzIGjflPcbC3vn8fcmM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Fri, 28 Aug 2020 20:28:58 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 20:28:58 +0000
Subject: Re: [PATCH v2 4/7] drm/amdgpu: Fix SMU error failure
To: Alex Deucher <alexdeucher@gmail.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-5-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_OMukMG3FzFx1HUN7vvpFgt2TXtB_BmKQ+Bm8SNhCmeiw@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <000cc30d-1522-fea3-c87a-ad250aba01c0@amd.com>
Date: Fri, 28 Aug 2020 16:28:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_OMukMG3FzFx1HUN7vvpFgt2TXtB_BmKQ+Bm8SNhCmeiw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR22CA0033.namprd22.prod.outlook.com
 (2603:10b6:404:37::19) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR22CA0033.namprd22.prod.outlook.com (2603:10b6:404:37::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 20:28:57 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:a840:fdae:31dc:3ab6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a237b9f-aaa8-405e-02f6-08d84b90fdef
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11457B11C82679884DB054C3EA520@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fg5vx5Y2/W0jsW02YkLiRbIF7vVGdq7n2LE+zR/oT/cHr7walVYONYYGEClem4MS2sHPunxHWXm41fOmtjZEYDoqzNHhu/BsNX5CoJ6Ob9TUThUUhqwvDBGIOyRoULF0nMV0mHbXV/XRLob1ynRct+z/R5HzGRzS5O1ssfmnZdt08eKKPo/e2rCzLkzGlTdMdeR3fYqR1Eiodoa3x7m5Dh3CoH18nrm/+shxnLjWmws/pmUhghCwEIAVXmEUnj0vOgf+zpntl368o8LsaGaDlcvSVQIkFR/gUotab1W2ixSB70SR2M57CqxesdZL9cTAu6ykMXdOH2OsVoNdyfaZlelqCLvILlgiKFZCE0ZCgQpwnETscbYSFi/y9a9YxhpXs57RYy0vZiV61PPxBlB50tvUYWVyLXUHMJuiEQfJ1KI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(66946007)(966005)(5660300002)(8676002)(478600001)(66476007)(31686004)(45080400002)(4326008)(2906002)(86362001)(6486002)(2616005)(31696002)(956004)(54906003)(316002)(36756003)(16576012)(6916009)(83380400001)(52116002)(8936002)(66556008)(186003)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CfD//+rAMnEmle9u5FURqLQHOcpet6R5fugibP9pt92LkrwQFTHxOktbZqzIZhD67Sl4PvZVNfoCF0HOt5ArrefuBtJLqYB8W8CeXIA9hxQWWPlnkKC97BmMv8BO8n/IFx2ECMwQwehJbIw6eEoHcgi0MAuzlFNBuO7801fOmAQ9Bh6OaCzX84rNZIKWCxrov7HCHbunFPsP12kmV1+85TXRgeyhRAtlGBaVfYLaFCOkQlB6lG34e3PB1WfzVnDM3u2Bpx91Z5kQD9Ta+3DTLTkK2GRBMJ/fmu7lPUJMKYXsrG6udtmYE5fp1P2LOJ5XYV9gAFmJg7PWMS573Rw4V5n8Ba/y3W86qgnUWiNpeDin4VjhJqMuBvoV8dqsxfH/mqgqbcUpDG6S52+uY9SrubJA24mOpj1VNAQLSi5OX1vJZNf/UkP6cZ1p+D21VBrBELrWwWkgnoUlFbbRuuP8YiimStx41eZ4tlxGbOADB3Oi0Ze/DAfQqs5/gv50wvGqauEGFlZw1IxzaBXFHBXUBlkYFLr2msFDU+2oNPq/WTbpHNJWDlrtGZjZqIpyzzdmmaC/CP/jf57BQG6uwdl8Rx1GbTeO0WqJhFyd4KMZlUBWH9OPMfpI3k7KN9WFNc7ndWUCxXV84sBeFsgReJh8dez8jjvwps006RQvDCoL98NGefbx5Oboj9KpCCs7K/DhL+i2A5fg3YvUIApFG6Il8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a237b9f-aaa8-405e-02f6-08d84b90fdef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 20:28:58.3356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3ltuD0z2MVrFNFnftxxSOoqyeFK6XNp2iDbR0yepcFlLPOAfWNXfjtTpE//moYDFGzT4AM7MVLholQKBDT0EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/28/20 3:29 PM, Alex Deucher wrote:
> On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> Wait for HW/PSP initiated ASIC reset to complete before
>> starting the recovery operations.
>>
>> v2: Remove typo
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 9a367a8..06664a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4844,14 +4844,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>   {
>>          struct drm_device *dev = pci_get_drvdata(pdev);
>>          struct amdgpu_device *adev = drm_to_adev(dev);
>> -       int r;
>> +       int r, i;
>>          bool vram_lost;
>> +       u32 memsize;
>>
>>          DRM_INFO("PCI error: slot reset callback!!\n");
>>
>> +       /* wait for asic to come out of reset */
>> +       msleep(500);
>> +
> I wonder if other reset paths need this wait as well?
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


They already have this (see psp_v11_0_mode1_reset)

Andrey


>
>>          pci_restore_state(pdev);
>>
>> -       adev->in_pci_err_recovery = true;
>> +       /* confirm  ASIC came out of reset */
>> +       for (i = 0; i < adev->usec_timeout; i++) {
>> +               memsize = amdgpu_asic_get_config_memsize(adev);
>> +
>> +               if (memsize != 0xffffffff)
>> +                       break;
>> +               udelay(1);
>> +       }
>> +       if (memsize == 0xffffffff) {
>> +               r = -ETIME;
>> +               goto out;
>> +       }
>> +
>> +       /* TODO Call amdgpu_pre_asic_reset instead */
>> +       adev->in_pci_err_recovery = true;
>>          r = amdgpu_device_ip_suspend(adev);
>>          adev->in_pci_err_recovery = false;
>>          if (r)
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cbcd9cce89b49498ecc9808d84b88ac73%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342397661929023&amp;sdata=imwQ%2F25z3XUPWlPtnP2UTCfRmv3Ejx04zWvOHn1Re7k%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
