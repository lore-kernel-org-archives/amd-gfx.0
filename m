Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFCDC4363A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 03:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF2520719
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 03:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v/l2mR7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF2520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BF96E03E;
	Fri, 23 Oct 2020 03:16:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 634E76E03E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 03:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWcGa+Uhvg1Ru37B0j+Qtezf4py5LF2AJxQUtMvFVr7skUIqIKlg0hdXjTkDsRewP7zQtWA56DWJjH0xeKhAl4o38/11/J0k9Y+8AmnaFOD5rhCnln/UtJsK67xLY0+vZUlT+EToy+X7XqvtiNVbJPGjJBHCBrsbhOBL7RWo++TAETLbkzCeEPKO0IDhWtUtOjAJC04wAJZZGEIon1dm94UqzCS3Q1nR1nigZQ87/g73g8UmM32+mT8xecOx0crYh/d88GrEcrHeId+qNLWgiRgTGs72u06WXFkJT9dvRlvDyy6X4JF+DE3VBL9z8KGssX0Zn9OhD6t/DF2AKyBdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQnXAjaRjhPBx91VuY7iK2JdKd53Q0rsmAjH6nmgmtk=;
 b=OQHRlyZSLxbUq2h+UtpzWFwxJhVAwkNJsjAcAdqtS4ItCAryO8uMZFU7MbeUYMptqfW9lPe1Fj6Oqg8L3fIvN20XEN1tEfLA2gwbXSsEe/zQ1uS/V67su9Atoh6xU3yb3o+BQS4C0PWjdmNTkJ8edSE7VRy/3y9JgrqYJ6u1Ie0H23y5tem4Floh+LKseZ0rWK2W5Oh0Vgt5IUA001MVOoXnBHFrRh6exSoPmJ7krrK99Ekf2YALWl5Wum3TqnySPHhkGzH1fIbVqOd3D6XylFW/1dc3+u7aqKFScMVDaRnznXPS41rLd0XUQPUem5Yl1AcKO+rMXyUYMu/Ph63buw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQnXAjaRjhPBx91VuY7iK2JdKd53Q0rsmAjH6nmgmtk=;
 b=v/l2mR7HSflan5kKJaFOs506fmVTmSsmP/6Fw4JOWvCAs3QTQ2zVZiTTuUiJmkfcq+HudwHjU9bDPPkGsQlz3vMRLUPP8nybqDF9BIu082NB3b8VWLQiR73ekuVt/haAXIWBHkJQ+mY8SQS1peQMAvFVG8NCF01JvyGIprledWw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 23 Oct
 2020 03:16:06 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::5c2a:30e:80ec:36bf]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::5c2a:30e:80ec:36bf%3]) with mapi id 15.20.3499.019; Fri, 23 Oct 2020
 03:16:06 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: disable DCN and VCN for navi10 blockchain
 SKU(v3)
To: Alex Deucher <alexdeucher@gmail.com>, Tianci Yin <tianci.yin@amd.com>
References: <20201022034309.7568-1-tianci.yin@amd.com>
 <20201022034309.7568-2-tianci.yin@amd.com>
 <CADnq5_MeJxe5VO1o-+x7rL-UvJGEKy3PrE7zrNzb4hxZ30Rkmg@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <64937339-912e-ee16-4071-846b465cedc2@amd.com>
Date: Thu, 22 Oct 2020 23:16:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <CADnq5_MeJxe5VO1o-+x7rL-UvJGEKy3PrE7zrNzb4hxZ30Rkmg@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 03:16:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86e634d6-ea41-4dd6-7a2a-08d87701fa97
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB485828C27C7CD4A0A399431B991A0@CH2PR12MB4858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRm0vYn2zWbjk/0VaWxlbVPwksjj1SygxlucDHIWeG4h412yQ23Ln076fKaSRcb+wbHpjrGExSzawadjSUW+6XwxN5mCh7IOKmhJZwooxAtvlTLCWuOXxRQNbQpcUS22xz1qLH/ds70uh3YbetAz2kZG6ix0x0SD4YZ9C2m6kpUJoouOtfdRwPruJUBDfOW2H6ZL/j9SO/ihVIIJw/zfJALRg4o3Io4At6Edj+PxlPQFXi0kaQn23qBQ0AF7iQRJTA16N6e+H5p8+sdDpaDf7IGHKJ0coviyFLNMjjtVMRcBbadh/ZpT0I+g+cgv9VdclX52KPpfzcZ+4sqAqyNxAhHjdv+MIYFFoW139oOI+kplBmzqR9K//MeDWnlC42NQ0LhZe5ndj8GjwzeRiQ+br19lKstN+oiSwLfe1qfuqBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(316002)(966005)(5660300002)(478600001)(31686004)(8936002)(31696002)(4001150100001)(2616005)(66556008)(66946007)(66476007)(4326008)(54906003)(956004)(26005)(36756003)(110136005)(45080400002)(44832011)(16576012)(52116002)(186003)(2906002)(53546011)(16526019)(83380400001)(86362001)(8676002)(6486002)(6636002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dwA0ZQAuCT2xVzsg3ZyMhIuq0WtSng3b8hnYv/zWqDMroTJTNSdBR/BQ8DHkQ6AJNeLpik23iyeCDnvBDsZodAg49iY5ogqMSfILTaNU7zjaa0BHFQTZw6oLL5YzKVTNFeNuXWu2drY8XeItlCN0Q/5HiL5C/fso1oDCt90cHp1thFYDvmCGgYo4VBOEI/mhDSAKpchpHZFE6+U85NQ3DUmKTd6b+9jmk/HbFXxBajux011E67T1rk1C0d5xw9cyncsOm+SjQ2IgnnJowM7qZe1PO3wZGxbPLIOExDcOnXXl0/EPoWFSLKsZsU6cdF/hD+fX5c8Ev/tzZUrgJouDIm3nRbwMVVpLglcSN9IQkB61+FZs1gYO9aBF2d28yXfztKOmZMB8PgK/CJoeaYTkQiuc6FG7TfVkkV5kaNhMUFaNko1uD2h7gRdDOI+rmuu2lyFEADEXfXi3SLPlqxYuELTlCRHYNFfCmARYeSxShBTSW+8vn8ZQb2ag4njWc+VwmbhZSBS7T3AQrTZxl0qPiqLxV7bK4V8BDLMf9dXVAL8exen0bSSK+nlwpi9hiN15eB6kom0iWhpKIn9Ck4NbAJ3qrFEsFUZgscFvZ1otSspnIdePbhy9V2UCJMoXtDd5Y/BWnJEdQlxJvI73IVS45w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e634d6-ea41-4dd6-7a2a-08d87701fa97
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 03:16:05.7847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDfHvZ88BAZgSWf+lf9stYN4+Sv4GDpbtJn6xATeKT+18PlFiBsmuKlUwQ55nnSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4858
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
Cc: Long Gang <Gang.Long@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-10-21 23:45, Alex Deucher wrote:
> On Wed, Oct 21, 2020 at 11:43 PM Tianci Yin <tianci.yin@amd.com> wrote:
>>
>> From: "Tianci.Yin" <tianci.yin@amd.com>
>>
>> The blockchain SKU has no display and video support, remove them.
>>
>> Change-Id: I419cfae8b00125f3bff18c0a8cd92f3266d5f04a
>> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/nv.c | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index ce787489aaeb..26702c85caf8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -497,6 +497,14 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
>>         adev->virt.ops = &xgpu_nv_virt_ops;
>>  }
>>
>> +bool nv_is_blockchain_sku(struct pci_dev *pdev)
> 
> This can be static.  With that fixed, the series is:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> +{
>> +       if (pdev->device == 0x731E &&
>> +           (pdev->revision == 0xC6 || pdev->revision == 0xC7))
>> +               return true;
>> +       return false;
>> +}

Not only can this function be static, but this function
can simply be

{
	return pdev->device == 0x731E &&
		(pdev->revision == 0xC6 || pdev->revision == 0xC7);
}

:-)

Regards,
Luben

>> +
>>  int nv_set_ip_blocks(struct amdgpu_device *adev)
>>  {
>>         int r;
>> @@ -530,7 +538,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>>                 if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
>>                         amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
>>  #if defined(CONFIG_DRM_AMD_DC)
>> -               else if (amdgpu_device_has_dc_support(adev))
>> +               else if (amdgpu_device_has_dc_support(adev) &&
>> +                        !nv_is_blockchain_sku(adev->pdev))
>>                         amdgpu_device_ip_block_add(adev, &dm_ip_block);
>>  #endif
>>                 amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>> @@ -538,7 +547,8 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
>>                 if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT &&
>>                     !amdgpu_sriov_vf(adev))
>>                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
>> -               amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
>> +               if (!nv_is_blockchain_sku(adev->pdev))
>> +                       amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
>>                 amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
>>                 if (adev->enable_mes)
>>                         amdgpu_device_ip_block_add(adev, &mes_v10_1_ip_block);
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CLuben.Tuikov%40amd.com%7C69a8d879c10a4a95df8408d8763d00da%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389351678043728%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=rW2Fz1NGYDoUQ3TlHAXmoDC9zDhBrBmxMtKtrsK0Fhk%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
