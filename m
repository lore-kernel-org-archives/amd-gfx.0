Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57791C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A63230FE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 02:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A63230FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D80F6E3DA;
	Thu,  7 Jan 2021 02:31:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E986E3DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 02:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi9QriGi0Bvs9NTLUSONSaV10eoVMlTsYnJKfVDsY/I/rc1WPiV6RESptXa7+zzQYFfKsDQ3LRn7Q0upRTMQtsn69dGXdFyHlAyWqMskSYlKiS+/pgaRflGjd+Ms/HG/lDJsq8RfI0MlUCObMi5KUz8cmz9r7abnBs/7x5c/sR/WbC4koeYWUlxmvxRuP0Qkqxs5a50hwETIxa7UM++NBKRf4X6ChRpR9YyU4s4W2iL1yEgLJ+Jw3o+zHCEW2L4jojMudMF1guoE+PqHQVAO0BhUYsbcH+S0rJv4dzNges2lwo+HBMlRFX+z7jRJx2uwQM48wBRE1Yvs0odYXeIlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSXz4gUDFWYtQnNP4ZmbGCuxLJUYemGSerDEU39SZro=;
 b=Bjnoarp7e0roGGWLVGnIswKc/xq5uKhyT5EJe4nseoo+6Z8KMlpg2dFEDaY29l8aiCJ9Vnqcy/L5ptgF8+fk5ATkzNmx8R3ZD87VAonYHZgGVzZ3BsKvATrfuAqTYJOjbOy1CnrW2PsbGI9YYvcVTbhwFJY0vn37skvxVRAVn2oS0Aqv/nnFOiK/DbLzBitDOVf1USoKZtKD/449YNpO1qhL7OrXVItJD0GYKYNmbJpBYjfha7UUzOELcRTxDE46N3jOF7mb68sUxxYAvPVO4gamBuWGwbwDcL6/Wxq2ldj5kSPT3kvIYfhGdpWOPuiHjhVZwWbusNP2+uKGD1Ppqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSXz4gUDFWYtQnNP4ZmbGCuxLJUYemGSerDEU39SZro=;
 b=0BYjCT8f1vmEzOAsn6uW14x+10HqQUFf2MkV7XRHhoC2oi0eSD9GeZiNWthpWfUfz3A846SlNe3PPzPV5w4xNTW0RJ7rrSqN1uXRGFDUm7juDFz3Kdrq+ztQDNw68uSBitbMUtbeOoC9Zj2vEnnzTxTXQji2A5l8g3pzzvKv0zU=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 02:31:09 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 02:31:09 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH] drm/amdgpu: For sriov multiple VF, set compute timeout to
 10s
Thread-Topic: [PATCH] drm/amdgpu: For sriov multiple VF, set compute timeout
 to 10s
Thread-Index: AQHW5CD4MdGEqY87q0iPdGnO7Kkjj6oajcEAgADj3OA=
Date: Thu, 7 Jan 2021 02:31:09 +0000
Message-ID: <BY5PR12MB411535B42F2497E935EC89148FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210106114157.566182-1-Emily.Deng@amd.com>
 <1b4eca35-6aa4-f463-ccc5-a4144bd325dc@molgen.mpg.de>
In-Reply-To: <1b4eca35-6aa4-f463-ccc5-a4144bd325dc@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9bb2b459-aee6-4f1e-989b-bd517d6395fa;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T02:29:34Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 476cf206-6917-4468-0ab0-08d8b2b44b23
x-ms-traffictypediagnostic: BYAPR12MB2966:
x-microsoft-antispam-prvs: <BYAPR12MB29661217BA6ADAD475C481EE8FAF0@BYAPR12MB2966.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKWB+uJos+7/woBtpAvRHHddpiocm9/4ZhJB1fJaHgN+/i5ErZlfrNKlkitl5Z0eeu29W9dHlcxWTG3SOzF/sEe+YQ1IRTWvagiXdXfuFx3rCg9IkWrVgc8v2O29Sp2dE+FV1XyWskSU61yzBN+QfnDRk7rAF3t6X8C88OoSrnlkLRTS1Yzut9Uu31vWny30RQrMCpylLwaNOQzLy+92O08RtIBhTmCadZBM61542ypXRbVRjRwMfx0yfL8dqips4b2zEawEzefuEZ7IJ+UfVPrJhAZnVZIyY2N7DTEmAduUCVGBpLAdJyhSudBDBSeWnkGwC6iqs2DCoaVJUjHs6UJzrPqqFEb70BaEzs+0Obsyi9H3DTo2BW2uDqLexHR32wnlwGPzW/QyZt7a9KxHuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(66446008)(64756008)(66476007)(66556008)(7696005)(478600001)(26005)(6916009)(186003)(33656002)(86362001)(76116006)(66946007)(52536014)(9686003)(316002)(8676002)(4326008)(2906002)(71200400001)(55016002)(6506007)(5660300002)(83380400001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d3ZTMGpTL0hhc3dERzkyVzRWR21HYTZnalRQWGtscHlpMTNGMTIyZGJFNzA5?=
 =?utf-8?B?SEovcStEVlo3Q21ZMzZwTmRhNVRLc21PVVhBU2JUTGVDcnhYZndRcVBIWlNj?=
 =?utf-8?B?RWJKQ3dRWkpoRCtnUGdLZ3I0dkdqdkR1bk1yUUdRc3V0d1VQcGxXY0phMXlO?=
 =?utf-8?B?MGNGL2lJd0lwUW1hNFhvNGhvQm1hemVOSzE5WHg3azhyWW03WUNKZEhHd1V2?=
 =?utf-8?B?ek1OMHhaNmtlRGFvRFBKUUMwTG0yYzZzTStnaDUyL1hRUE9DNGhVblpVUGNm?=
 =?utf-8?B?Z0N2ck1FcTI2Z1lYcXJscVRSUkZQMnZHMEs5dXA1TUtmVWdZcmZRc2tyWHF2?=
 =?utf-8?B?VEdEUmJ4c1RNY0N3dy9ZSDNkVTFkaisyWVBQOHgwamY4TFM0d3VlZWNHbHF2?=
 =?utf-8?B?Zlc4dVBkS3JZaW5wYW9FZUJ6bVV4dmZWeWxSamJCcEthQ1N4OWJiVnYxMlBH?=
 =?utf-8?B?aU0xWSt6eDhzQ08xbWZreFpnZFdzZWpPZFM4dGgvdEhKeEZpZFRRb283RVBV?=
 =?utf-8?B?ZmdSekZxQ2pyeUR3WFpPbUZzaE8yNkIvMFE0UE44eXZXYXJUMENsa215VHhy?=
 =?utf-8?B?WXNEOHNwcXduakZidHl2MDYxZ2xpSWxoWlpVc3FEc2JNK3JzSEk1VFNoOUxj?=
 =?utf-8?B?UVZQdWlDZjN6NjhpSFVOV3NnWWNtV1VRY280ajRXNnY1RXFEZ0NiV0JKdzNy?=
 =?utf-8?B?Wjc3TXBaOG5VQ0crc3Q0b2hvSHpiL3VOVE51a3hYRm9iNzVsU2V2d2ZSVVht?=
 =?utf-8?B?cGZ0emRkak1OQzhmSlA3SUwvOTMwTHRYWGNlQkFDMkFnbDFIRmtiNmd6d1Qy?=
 =?utf-8?B?RDhZMjU3cG5RT1NQcjQ5QVFSam9EaHVOQWtFM3Y0Y1ExaTlhKzY2UjdaUUd4?=
 =?utf-8?B?eXdyRnU4RUhLYkphclpQN2lVR3l3K1dXanNwa2syNU5Qa0c1RHdHdkN0T3NW?=
 =?utf-8?B?eHFLdjVWMVpycmRmZjVIMTdSR3lVd1RiR2VFbXlEZWdQVmh0THZNM3dyVzZp?=
 =?utf-8?B?Rzlsb05EM0J5R1FXdWVPR1lQOTU1REFpZUttaThPaUZob3JqLytmUkxTZ3R6?=
 =?utf-8?B?bFkvZGkyVkZPQWorWng3K3pUbGhFbTBqZWlBdTF3NFY4US92VUlWVkQ0MkYr?=
 =?utf-8?B?Y0dDTlk2dExiaC9GdmRoVVlrM01WdmVsM1pCbmttSGVrYjMzLzN1Y2V1cEp3?=
 =?utf-8?B?VTFyMzZiWGwzREhvYWpMc295Y1FFL1drbXlrT0pOSTBnTGRwWlVoV0htVGs3?=
 =?utf-8?B?TWV2Y2ptb2Z1c2wwc0JtYlU1OTBSbFlYWnJFeURzVTM1aUloN0huWkNvM1BD?=
 =?utf-8?Q?pH4K4SZ4HR9a0=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476cf206-6917-4468-0ab0-08d8b2b44b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 02:31:09.6255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDH4tLxj4H7OOQDaoaXMFUphOOTBXd2ftPvn6eJZrDM14u0TARyWigzugXKnV006
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: Paul Menzel <pmenzel@molgen.mpg.de>
>Sent: Wednesday, January 6, 2021 8:54 PM
>To: Deng, Emily <Emily.Deng@amd.com>
>Cc: amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH] drm/amdgpu: For sriov multiple VF, set compute timeout
>to 10s
>
>Dear Emily,
>
>
>Am 06.01.21 um 12:41 schrieb Emily.Deng:
>
>Could you please remove the dot your name in your git configuration?
>
>     git config --global user.name "Emily Deng"
Ok, will do this.
>
>For the summary, maybe amend it to:
>
>     Decrease compute timeout to 10 s for sriov multiple VF
Ok, thanks, good suggestion.
>
>> For multiple VF, after engine hang,as host driver will first
>
>Nit: Please add a space after the comma.
>
>> encounter FLR, so has no meanning to set compute to 60s.
>
>meaning
>
>How can this be tested?
Setup the environment for sriov.
>
>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b69c34074d8d..ed36bf97df29 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3117,8 +3117,10 @@ static int
>amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>    */
>>   adev->gfx_timeout = msecs_to_jiffies(10000);
>>   adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
>> -if (amdgpu_sriov_vf(adev) || amdgpu_passthrough(adev))
>> +if ((amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) ||
>> +amdgpu_passthrough(adev))
>>   adev->compute_timeout =  msecs_to_jiffies(60000);
>> +else if (amdgpu_sriov_vf(adev))
>> +adev->compute_timeout =  msecs_to_jiffies(10000);
>
>Maybe split up the first if condition to group the condition and not he timeout
>values. At least for me that would be less confusing:
>
>     if (amdgpu_sriov_vf(adev))
>     adev->compute_timeout = amdgpu_sriov_is_pp_one_vf(adev) ?
>msecs_to_jiffies(60000) : msecs_to_jiffies(10000)
>     else if (amdgpu_passthrough(adev))
>     adev->compute_timeout =  msecs_to_jiffies(60000);
>
>>   else
>>   adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
>
Good suggestion, will send out v2 patch
>
>Kind regards,
>
>Paul
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
