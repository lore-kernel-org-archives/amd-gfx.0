Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3451FC35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCE82176D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tpMigPVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCE82176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984256E8E4;
	Tue, 25 Feb 2020 15:33:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDF5F6E8E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 15:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX6tUQLr/63ll5QjC0sS9Ex9tDhziXWG9x/ar35mTYSNiYkAagCuCtCN3P2BKjfWkzayoeuagBiXljKQj6zJf3GeNXXkrUq+soDB0XGHqN0uXIDGuJc0oFPSYQkzgM6nsdwqo+x8yVkpaItz79bwLJh6kbqEWJtiHIfQnjXh2nN+eQ/8xGJzYm3XcRVLTfLOtnscZnSWRupXnD5MvvP3ToQJM36fYlLycQxhx5eBdPc7T6d0x2THl7+9Gl5DiSLKG1TIvz85CfnJxXfNgN60hAXSXpUp0VKlNlwzYjFv5BfUVgrvxQ6F3ielZdFg6o1mMW/k5a2l9UP/SeHEqpkOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzlyJFwp9eP5CMAZB5amxhNavEL0wOEabAMJFhTlm3E=;
 b=oa+1uH8jfDtj1OQZjs6fU2N796PKyvEqgWRCJzrhCA0Xem9ARYaJjbIs2QMptsasQfgwjWFQ9kC+NWSBTo5Rz85VqaPKLeXmZJgu7OlFvglLwL0+RXa3ZbbFXRFMw8bUQVLEtD+7N++55GZU4/lMIM+zP6oI2+ynxycE6kVAr1hc7+27yfEOiMSHmbsf7qAu9+t1JS6SNAMJ+EPCVOilpaf3w7N3iX8eR7fNUfDuHCSp6cVeJCOassCSl/AtVFczDnchBBkEmnY7cH1eBwTBv08NvCs2baZ61EvuesCDcwsL1g1ENBhZoZ6FYNwOeSiriUshdMhj9bcgXFszUrG91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzlyJFwp9eP5CMAZB5amxhNavEL0wOEabAMJFhTlm3E=;
 b=tpMigPVVYCW5xTg/Xh+/BiBVTTB+6JkmXnVQiTpwpbGyce8+TPfIcY27E1xZN8L0EjgsgmxJcn1F+f7KofAo1hAYRuRjiZus0OvuLA59pmN6m32Fl9xXvsxzzPzjXLFd9ovYbCi6mUkton9pEDd+mxrLb+jLtU0FJQsVO4BNFWU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bhawanpreet.Lakha@amd.com; 
Received: from DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14)
 by DM6PR12MB3388.namprd12.prod.outlook.com (2603:10b6:5:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 15:33:11 +0000
Received: from DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4]) by DM6PR12MB4236.namprd12.prod.outlook.com
 ([fe80::91ac:1f2d:b4ca:c0a4%6]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 15:33:11 +0000
Subject: Re: [PATCH] drm/amdgpu: log TA versions on init
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20200224194527.15599-1-Bhawanpreet.Lakha@amd.com>
 <DM5PR1201MB25540AA66E86F5FC291898CB9EEC0@DM5PR1201MB2554.namprd12.prod.outlook.com>
 <DM5PR12MB1418B4C3BE0EF80AA06C6ADFFCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
 <DM5PR12MB141834A0DCB1065A37947588FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
From: Bhawanpreet Lakha <Bhawanpreet.lakha@amd.com>
Message-ID: <120675c0-35c5-118f-ff54-d7a9a1503acf@amd.com>
Date: Tue, 25 Feb 2020 10:33:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <DM5PR12MB141834A0DCB1065A37947588FCED0@DM5PR12MB1418.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::40) To DM6PR12MB4236.namprd12.prod.outlook.com
 (2603:10b6:5:212::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.2.119] (165.204.55.250) by
 YTOPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::40) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 15:33:10 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 386e0e00-7fb4-472f-b41d-08d7ba080583
X-MS-TrafficTypeDiagnostic: DM6PR12MB3388:|DM6PR12MB3388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB338890EE1D7BA2B42E919929F9ED0@DM6PR12MB3388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(199004)(189003)(2906002)(53546011)(8676002)(81156014)(8936002)(6486002)(36756003)(81166006)(5660300002)(16526019)(31696002)(186003)(86362001)(478600001)(2616005)(52116002)(66556008)(316002)(6636002)(956004)(26005)(16576012)(31686004)(66946007)(110136005)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3388;
 H:DM6PR12MB4236.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xo2qb9U7xknD/5O+79cmqQxZ+hxjBOtcMOQgVA7spo5VjxitkG8McYHEIu5TWXaDh5xVaDtlmb2/XfVqj+VG6dt31zOnakIUGPShl8Hms67k21jXYJVbiHeZ7I4+ZgbjRIQDmwMDpg1XE+/90oB5sz0MxTmSLSsjWd54NQrOSCUmwwcAtQjpfj5ViqDv6UjKjDYKQJWwMUUJ7LJtp5B1F3MPx+7U7cR1Q7xUfI+qlBVU9CZabjV+GxVLzdSXZYvHlEUKRvQNTgbSrObaxh9R5q3qxkwpv5v1kupoksDiFjw81RP+p50r0ApEmgAfWcQzphyWVwWT0pLqsukGeBrugENcQfjOcmA/hYCWfV6HhK8ztPA7RS7eI8ZVMnefxZgMGXdcvNcAy1b9vctCET09Zm7hcIIB3J9rQWWas6Igjf7B8xHHKhZDluyz7rDpY0Cx
X-MS-Exchange-AntiSpam-MessageData: A/TeXGwqzSrHZjUTA9OJa81t1cnnM+PNHHluEWUuDXKs4OJd03ngqSs6W8aQafOkDtAbG21tEzjOY7AhepL097lMz634L/E5HpucsYFldzKbIpjzFMfAKIHEzdbe32+th2kzpkvsQr0Nre7/XYlUqw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e0e00-7fb4-472f-b41d-08d7ba080583
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 15:33:11.3894 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGL+ugTQ0Xx+8pT+72kJKG9M5BRRpRYVMZoQIHk5Z1q+fNQJN9XHGrazR/LGHHgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3388
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Hawking,

The goal here was to know about the TA versions from just the dmesg 
only, its helpful as we don't have to ask the user to query data again 
as dmesg is the first thing that is usually shared for issues.

For now I will add it to the debugfs.

Bhawan

On 2020-02-25 1:29 a.m., Zhang, Hawking wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Specific for your case, you just need add dtm and hdcp ta version in amdgpu_debugfs_firmware_info, Similar as xgmi and ras ta. The following cmd will give you all the firmware version information.
>
> sudo cat /sys/kernel/debug/dri/x/amdgpu_firmware_info
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Zhang, Hawking
> Sent: Tuesday, February 25, 2020 14:27
> To: Liu, Zhan <Zhan.Liu@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: log TA versions on init
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hold on please.
>
> I don't think this is the best approach as we already had existing debugfs interface for that purpose. We shall centralize all the firmware information query under amdgpu_debugfs_firmware_info, and user should go through debugfs to query firmware information.
>
> Regards,
> Hawking
> -----Original Message-----
> From: Liu, Zhan <Zhan.Liu@amd.com>
> Sent: Tuesday, February 25, 2020 04:55
> To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: log TA versions on init
>
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Bhawanpreet Lakha
>> Sent: 2020/February/24, Monday 2:45 PM
>> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
>> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
>> Subject: [PATCH] drm/amdgpu: log TA versions on init
>>
>> It is helpful to know what version the TA's are for debugging
>>
>> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Reviewed-by: Zhan Liu <zhan.liu@amd.com>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index a16c8101e250..09d1433677a6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -358,6 +358,7 @@ static int psp_asd_load(struct psp_context *psp)
>>   	if (!ret) {
>>   		psp->asd_context.asd_initialized = true;
>>   		psp->asd_context.session_id = cmd->resp.session_id;
>> +		DRM_INFO("ASD: Initialized (version: 0x%X)", psp-
>>> asd_fw_version);
>>   	}
>>
>>   	kfree(cmd);
>> @@ -518,6 +519,7 @@ static int psp_xgmi_load(struct psp_context *psp)
>>   	if (!ret) {
>>   		psp->xgmi_context.initialized = 1;
>>   		psp->xgmi_context.session_id = cmd->resp.session_id;
>> +		DRM_INFO("XGMI: Initialized (version: 0x%X)", psp-
>>> ta_xgmi_ucode_version);
>>   	}
>>
>>   	kfree(cmd);
>> @@ -658,6 +660,7 @@ static int psp_ras_load(struct psp_context *psp)
>>   	if (!ret) {
>>   		psp->ras.ras_initialized = true;
>>   		psp->ras.session_id = cmd->resp.session_id;
>> +		DRM_INFO("RAS: Initialized (version: 0x%X)", psp-
>>> ta_ras_ucode_version);
>>   	}
>>
>>   	kfree(cmd);
>> @@ -832,6 +835,7 @@ static int psp_hdcp_load(struct psp_context *psp)
>>   	if (!ret) {
>>   		psp->hdcp_context.hdcp_initialized = true;
>>   		psp->hdcp_context.session_id = cmd->resp.session_id;
>> +		DRM_INFO("HDCP: Initialized (version: 0x%X)", psp-
>>> ta_hdcp_ucode_version);
>>   	}
>>
>>   	kfree(cmd);
>> @@ -977,6 +981,7 @@ static int psp_dtm_load(struct psp_context *psp)
>>   	if (!ret) {
>>   		psp->dtm_context.dtm_initialized = true;
>>   		psp->dtm_context.session_id = cmd->resp.session_id;
>> +		DRM_INFO("DTM: Initialized (version: 0x%X)", psp-
>>> ta_dtm_ucode_version);
>>   	}
>>
>>   	kfree(cmd);
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
