Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F1FC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 06:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15B92078A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 06:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0IV6jU/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15B92078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C956E15B;
	Fri, 28 Aug 2020 06:29:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA176E15B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 06:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhenZ5Vm19OssPdOfb9Yw8o134XYa9iR1CpHAWZ1E2NyulyFDOjvMwehxCmnsi3x5oMSTaVTruWteYmeAwsmCw+RJhaxk4drowvbuiAfdOdmNmM6qeR7Y/XrfsOoOa2jgwepHJn8Aj7qFv6gdawY4E2GA5vDRMjQ3IU6U0qvURa1zgwHvq19cOU671A4Y6dYPMaLhn9unBQZ7nwxyHUX8oXVx05ujeKNaOI8d+7RYsS4x57iPMq3EVKMmqbLnU463dg3oXbqCg7vWteAboy/4ww4z8nLuNoS9YIzLZCKXTfIYETPhOx8GQzTPTelDEaDxQoahawprbjemzT347a09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj6bJaGSTk1IaM3McDctz2Y0ccdYTG/GrXEIg3Lw5C0=;
 b=dQRmi0YtzEYTRuQMUk4UUnEdX44aFkBasQSIxfxxrXIAJaONJBhxO1usMTO7828Ywmd68EubFoY1TGxjolrPjqa7usZP2DSXbi1Z7xLdc7gvx1Y0r2xRLTLHJNh2kUC3P9M+/0b2JbCVVW2/KkOtpYmGeVx1M/Un7QAoz3zv/XeRoIAcpevzynKenXlLUHrLcvFH9CHu5Dm8mE9Ju5x0sPufiI5ZYM1CSsP7vmd/x2+3g1z+xGaKW2eLX/jlOkFvkFN6NlJ+C3XtzMB3v86SB/jwH8QaKZ8A5sm+/DUZ+IMreS+N0ZYRFWDwif2zZM+k0pNaJpqACgeOpSB2xScJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj6bJaGSTk1IaM3McDctz2Y0ccdYTG/GrXEIg3Lw5C0=;
 b=0IV6jU/ip1BeCt/NT9jXDpJ7qkp+hOFrh89DzTzSf1KqDajokh952bmefZ7dCAAF/lDmnDdnkC/EItkgfrY+1q/M4P1xCWFKz/VYJHv/o95HDXa7d1VLZ9+VzQXfAgFiiXtf5CNlCENwF9awC5tF6HFotQrQp01kHUpamQGnEk4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Fri, 28 Aug 2020 06:29:16 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 06:29:16 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
To: "Deng, Emily" <Emily.Deng@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200827151858.55326-1-nirmoy.das@amd.com>
 <BY5PR12MB4115985F3DA93723F8D2B82B8F520@BY5PR12MB4115.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <46f0841d-a2d9-88d2-9a53-46f07578532d@amd.com>
Date: Fri, 28 Aug 2020 08:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <BY5PR12MB4115985F3DA93723F8D2B82B8F520@BY5PR12MB4115.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:205::30)
 To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM4PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:205::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 06:29:15 +0000
X-Originating-IP: [93.229.43.9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2da91638-885c-4e13-11a1-08d84b1bafec
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1466923A1A9F250D7BF137868B520@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wvfz2HYwHFWVY5NNYJ9dZLOmc/QKzBS/hZQLncHMSWXuN1pL31cNTHYKcueHyg52t9r9kignxYQIvNYYabmkL+DdHxB49aQAjQHYoLCwblUFmrurbgBjf6Ox87yzJSFApfwXkU2X/0cjEn5KLxFZDczd+k7z2aoTrqOLY4TtaPPdIXXpXOUV5Fc2ni8a1aKpznLe7nf53+SFWYkYfQVwTSx2TH8jrnlVlk0FAH2TD66DzmJ3uvgh90roqOB61E/Da3bcBLrp/mwhGcD9NqK+wDRrkbPl2ksAQ3IMcmx7/3qCHkho0iQCj1vkTTg1BZXMrVFpqkYxbF+muOAltK2W/tdyrxUstSi2Tw5wye9acMZl9RLBX+TMD8G7O+HpYZHr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(83380400001)(2906002)(31696002)(54906003)(6486002)(316002)(956004)(110136005)(2616005)(8676002)(478600001)(4326008)(8936002)(6666004)(36756003)(31686004)(16576012)(186003)(26005)(53546011)(66476007)(5660300002)(52116002)(66556008)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mlyYAMAKyRsgdpYIbx9PkyAUfm57y/WcWlWTQONSRrsLpt/stlZLLCH8cOZ+lWWHEhYxnIxGcvEKeSWzrP/KI2x6ic0jOq2QXffl3xPbqCxntIdn6jtrKNxDkLI8xrS02hFjbA7ieOFtXkgCimV56ZQOabe1Z4/NWxSYUf8DI9M5kPJH4Pp+jx1b3AGIc/971nXCoZ/dxbre1j60GVhGzheyp/fES0l9OjOIlCvu5E24De97RNAr2wnblfZ+LTFMSgv5YOer6O5mnhZRQau8yUk68XXDQmlPqCWcEqCaj9fofyOAicBuLfencUgKA/Ax4dTMg1t4pn6x1P6/9ECIZiac6dVnIWRmZ2nQAhfLi5LagJFJ2qUn7mw45cIHvBJWnFPFA1N4MsP/baHGJLdLCAaFtbwpO6wUNO2YdIu+u9amhLxgMGo3668oyA9oYDrTkq4Zoolq5EFZrF0C8rxY3ZQi0HT+HOkhIeMvIwOWuhVEs9DPVegXu0ALbPlDs0JsSAe/A9fTOjvEP6EZkIYnbqj5OOMkYYRPN6jC89oGorACMVLvoLa1eVOQ0kqbEpqerlkS53fqqV48vcbiwE64sLX2Kh+HOnQl/J82CuchXOHbJkEUKdgX+HDT9XZZpV8UwpL+hlAJlABJuI7i6BA4SQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da91638-885c-4e13-11a1-08d84b1bafec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 06:29:16.3377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mam/Et+Y5otWf53YIv/yo8KUebNTnOFJyUHQos/rbqk5niqaavm3GT4xdsIn8NtsBAgLxeeIv6uSIoZTz6WiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gu,
 JiaWei \(Will\)" <JiaWei.Gu@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/28/20 3:16 AM, Deng, Emily wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Nirmoy,
>      Still think the original logical is more clear.


No problem but we should at least make sure 
amdgpu_device_ip_reinit_late_sriov() and 
amdgpu_device_ip_reinit_early_sriov()

are consistent. The last patch from Jiawei only touched 
amdgpu_device_ip_reinit_early_sriov(), same optimization should apply

to amdgpu_device_ip_reinit_late_sriov()


Regards,

Nirmoy


>
> Best wishes
> Emily Deng
>
>
>
>> -----Original Message-----
>> From: Das, Nirmoy <Nirmoy.Das@amd.com>
>> Sent: Thursday, August 27, 2020 11:19 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Monk
>> <Monk.Liu@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Deng, Emily
>> <Emily.Deng@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
>> Subject: [PATCH 1/1] drm/amdgpu: rework ip block reinit for sriov
>>
>> This patch removes some unwanted code duplication and simplifies sriov's ip
>> block reinit logic.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 117 +++++++++++----------
>> 1 file changed, 60 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 696a61cc3ac6..0db6db03bcd3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2587,77 +2587,80 @@ int amdgpu_device_ip_suspend(struct
>> amdgpu_device *adev)
>> return r;
>> }
>>
>> -static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
>> +/** amdgpu_device_is_early_ip_block_sriov - check for early ip_blocks
>> + *
>> + * @ip_block: ip block that need to be check
>> + *
>> + * Returns a tri-state value for a given ip block.
>> + * If an ip block requires early reinit sriov then return 1 or 0 otherwise.
>> + * Return -1 on invalid ip block.
>> + *
>> + */
>> +
>> +static int
>> +amdgpu_device_is_early_ip_block_sriov(const enum amd_ip_block_type
>> +ip_block)
>> {
>> -int i, r;
>> +switch (ip_block) {
>> +/* early ip blocks */
>> +case AMD_IP_BLOCK_TYPE_GMC:
>> +case AMD_IP_BLOCK_TYPE_COMMON:
>> +case AMD_IP_BLOCK_TYPE_PSP:
>> +case AMD_IP_BLOCK_TYPE_IH:
>> +return 1;
>> +/* late ip blocks */
>> +case AMD_IP_BLOCK_TYPE_SMC:
>> +case AMD_IP_BLOCK_TYPE_DCE:
>> +case AMD_IP_BLOCK_TYPE_GFX:
>> +case AMD_IP_BLOCK_TYPE_SDMA:
>> +case AMD_IP_BLOCK_TYPE_UVD:
>> +case AMD_IP_BLOCK_TYPE_VCE:
>> +case AMD_IP_BLOCK_TYPE_VCN:
>> +return 0;
>> +/* invalid ip block */
>> +default:
>> +return -1;
>> +}
>> +}
>>
>> -static enum amd_ip_block_type ip_order[] = {
>> -AMD_IP_BLOCK_TYPE_GMC,
>> -AMD_IP_BLOCK_TYPE_COMMON,
>> -AMD_IP_BLOCK_TYPE_PSP,
>> -AMD_IP_BLOCK_TYPE_IH,
>> -};
>> +static int amdgpu_device_ip_reinit_sriov(struct amdgpu_device *adev,
>> + const int is_early)
>> +{
>> +int i;
>>
>> for (i = 0; i < adev->num_ip_blocks; i++) {
>> -int j;
>> +int r = 0;
>> +bool init_ip;
>> struct amdgpu_ip_block *block;
>> +enum amd_ip_block_type ip_block;
>>
>> block = &adev->ip_blocks[i];
>> block->status.hw = false;
>> +ip_block = block->version->type;
>> +init_ip = (is_early ==
>> +   amdgpu_device_is_early_ip_block_sriov(ip_block));
>>
>> -for (j = 0; j < ARRAY_SIZE(ip_order); j++) {
>> -
>> -if (block->version->type != ip_order[j] ||
>> -!block->status.valid)
>> -continue;
>> +if (!init_ip ||
>> +    (!is_early && block->status.hw) ||
>> +    !block->status.valid)
>> +continue;
>>
>> -r = block->version->funcs->hw_init(adev);
>> -DRM_INFO("RE-INIT-early: %s %s\n", block->version-
>>> funcs->name, r?"failed":"succeeded");
>> -if (r)
>> -return r;
>> -block->status.hw = true;
>> +if (init_ip && (ip_block == AMD_IP_BLOCK_TYPE_SMC)) {
>> +r = block->version->funcs->resume(adev);
>> +goto show_log;
>> }
>> -}
>> -
>> -return 0;
>> -}
>>
>> -static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev) -{
>> -int i, r;
>> -
>> -static enum amd_ip_block_type ip_order[] = {
>> -AMD_IP_BLOCK_TYPE_SMC,
>> -AMD_IP_BLOCK_TYPE_DCE,
>> -AMD_IP_BLOCK_TYPE_GFX,
>> -AMD_IP_BLOCK_TYPE_SDMA,
>> -AMD_IP_BLOCK_TYPE_UVD,
>> -AMD_IP_BLOCK_TYPE_VCE,
>> -AMD_IP_BLOCK_TYPE_VCN
>> -};
>> -
>> -for (i = 0; i < ARRAY_SIZE(ip_order); i++) {
>> -int j;
>> -struct amdgpu_ip_block *block;
>> +if (init_ip)
>> +r = block->version->funcs->hw_init(adev);
>>
>> -for (j = 0; j < adev->num_ip_blocks; j++) {
>> -block = &adev->ip_blocks[j];
>> +show_log:
>> +DRM_INFO("RE-INIT-%s: %s %s\n", is_early ? "early":"late",
>> + block->version->funcs->name, r ?
>> "failed":"succeeded");
>>
>> -if (block->version->type != ip_order[i] ||
>> -!block->status.valid ||
>> -block->status.hw)
>> -continue;
>> +if (r)
>> +return r;
>>
>> -if (block->version->type ==
>> AMD_IP_BLOCK_TYPE_SMC)
>> -r = block->version->funcs->resume(adev);
>> -else
>> -r = block->version->funcs->hw_init(adev);
>> +block->status.hw = true;
>>
>> -DRM_INFO("RE-INIT-late: %s %s\n", block->version-
>>> funcs->name, r?"failed":"succeeded");
>> -if (r)
>> -return r;
>> -block->status.hw = true;
>> -}
>> }
>>
>> return 0;
>> @@ -3901,7 +3904,7 @@ static int amdgpu_device_reset_sriov(struct
>> amdgpu_device *adev,
>> amdgpu_amdkfd_pre_reset(adev);
>>
>> /* Resume IP prior to SMC */
>> -r = amdgpu_device_ip_reinit_early_sriov(adev);
>> +r = amdgpu_device_ip_reinit_sriov(adev, 1);
>> if (r)
>> goto error;
>>
>> @@ -3914,7 +3917,7 @@ static int amdgpu_device_reset_sriov(struct
>> amdgpu_device *adev,
>> return r;
>>
>> /* now we are okay to resume SMC/CP/SDMA */
>> -r = amdgpu_device_ip_reinit_late_sriov(adev);
>> +r = amdgpu_device_ip_reinit_sriov(adev, 0);
>> if (r)
>> goto error;
>>
>> --
>> 2.28.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
