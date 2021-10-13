Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C71C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 10:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DFC61040
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 10:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 20DFC61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF75E6E862;
	Wed, 13 Oct 2021 10:42:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB116E862
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 10:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5i1B1Ftj9q0IwUjEUWxoOyK7B09A46DXPnbENIXT0DS+2g+UbJRNB0bDSxbyofZ1y2FFbQGKqgAdpI8pYa8pE55F4zIlwaOEXjfi3J3v5CvZQIdiBd9KDumRJAOLTPx869VHeiGcTo0oTmKFE4O+ij2HksRW3E4uUTEzO9LR/5ZjWMJ5kpihf/X/V8zLl9iFxkjUJi56Jwus37/bcFXaY1xSyHfH5OMqkoIOFAgsP0VA/BUi3X8IJ3nnc8xVBvEjHhHXRAaweTbNFxWE3FqXUciB05AvO+zrPNkZXoZCP8bb/8Z3gt8tvtcSP/uN4YCHFUXxTGiMHJgRbHGJKA2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CevldAISnAuNezfKiWoXHcWAL+smf8JdU8+ZAYxDWik=;
 b=SCgvSLZOrgrkWCCSB8xmiEVH/12fpMc55GDtuViHFp+QfF9Dtwv4Bv7ZisLJzFzo0S6+lFyj+2SJTQIFDyS7wRYUWPgHUPXaJwtizt2tXnWTPJyyh9xH09VDXV3mehVRjonT7jYDWK4cSi7ysWOQLfF/EopXQ9JW47G1d0RgS2m9EWgXi3A+9lRZ71VExyRI1UbL3rkZ+TLoqDjRr/hcwVBVAiSty37sP+ebC2XQn8epAAcEimim8MqAoiRYIMPTasImgq3aW0FJml+8XNtsBuTcW9CKcShG9EsA7CFfaEHC0+rWnFikdqwIXlpHN4SjJXZSu822juxdgYa9jS4jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CevldAISnAuNezfKiWoXHcWAL+smf8JdU8+ZAYxDWik=;
 b=QLwqHH/eCj/aVkToIYRkWBXEo0o2Q60mzkI38caUwl2cl6ldfQNaM/Ryzn+aS/rRBbZfwH0nf1SIDqmu9kGhk95zS/qDC3vi4CWEiLYZe2cg96K/ylPnldmD0k11d9xOglhf7Uxr5Cw69FlLisulAept1G+Fq8WJyoEV+gGhK2I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 10:42:11 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 10:42:11 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: release gtt bo after each move test
To: zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <2be293df-2656-c551-682e-b08955307c0b@163.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <80ecf91a-1ae3-50e8-df46-01c013a1eeb9@amd.com>
Date: Wed, 13 Oct 2021 12:42:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2be293df-2656-c551-682e-b08955307c0b@163.com>
Content-Type: multipart/alternative;
 boundary="------------57A68FF4B94B70C9507F8BEC"
Content-Language: en-US
X-ClientProxiedBy: AM6P191CA0068.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::45) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [192.168.178.88] (93.229.33.108) by
 AM6P191CA0068.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 10:42:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ee8ac9a-be71-4c84-af64-08d98e361c94
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:
X-Microsoft-Antispam-PRVS: <DM4PR12MB523096931C594C774493FC598BB79@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2W9rUIeHALak1Nw+WMsJdsriS9+Iv7Odq6FR8gh21fZ4WN2XWMA0sx1HXTVuM1B7mGEJ8NDHHZOpAd51mFbAIIklsqMZK8C3G7rQQShn8HVeaVjiEurHiCfQMHrenqOBg4HcwAMQErtbxDOja8JLZJgtZFD8mCbyVX9RoARDb3bprV/6onUb4j7WrOwh2Sv3PbG+UqGQUK4IPgAQ3ORyLOUBU47YkBTVAcakOy1n6iA+0JpaoPvsz6nmv5DWe2E8Oj+nDfQa5grzvJ73y0plJ6DeHogzfgoOsCOlQClcmasdG4Ncws0aGwpLAdKqXCtlnqKxg75ZxsQ2z1q0doFhXm8MTKAzjSP4kvz9LaO8/WsLs0mSDZNibbjFKc0Gn6PBHi2Dx1SCYDOa8TKBOhffo1LEv6hffzLY0Dvxnad6tq9QgmsLgxn27RcVjdTcsJGrMyMY2yd7hC1tSgCu22vI4YRkYqARUQGRmTa0ibKqozqcYvmQ5a16j/ls/oq7JMi21mMTSjOyXovQnUisXt0CM3Cb/YiUc9e7A5Q1IwP4pQIvqOtbTqFfcpZaHYgJhorIeyadhLa28VdPkZnRBms1y3+W35zjo9tXBE6SD2tUTrc/pkUs88Xk539KXpSsSJaYWKGWcV/ubqCV1howeoeHcHtRBjANhKYd5FUbV8nmQL+EBFdBfuw8dtr3GVnYo1omaYk8iiKyjl8RUKZkqCZ9XVkGugdTf97aW0Ea46IFLqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(66946007)(66556008)(8936002)(6486002)(8676002)(6666004)(16576012)(316002)(508600001)(53546011)(2906002)(33964004)(36756003)(83380400001)(38100700002)(26005)(31696002)(2616005)(186003)(956004)(31686004)(4326008)(86362001)(6916009)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnplMnRwTENzTm0rY3NhWXJheEdsYTdSWmNOTWtURHdtbXh2aWhlYm54SCtR?=
 =?utf-8?B?UXplMWdzRk1sWFR4ZkRLRGpkdyswRGpQMmkxZjNUVlVBWVZlVXJhR2JiUWhH?=
 =?utf-8?B?dFNrWHpPOWg1YWR2TjRnTk14RzYrRVpmUmQra1VrOU1XSTl6QWhuenNldGRu?=
 =?utf-8?B?a0srWWd0TUJZY3pERkVZRGtFdTV5MG1ESkYrN05PcDlQMklWQU53YnNhWThG?=
 =?utf-8?B?TDdxSnBHN0Iyb1NZVG1MWi9ubmt0bnMyYWdIUEJiVzdWRVhrVitvWlBRZnFT?=
 =?utf-8?B?dm9XaTFhSDZOajYxQThlcFFVSmtzUUZSZC9YbmwrSmpqck81TEVWS3BZYWww?=
 =?utf-8?B?Q1o2UjVSZnl0T29mbXFkRkRSK0xnNitKUm9KbTk0ZFZnOGN2U29IYXJXZ3hm?=
 =?utf-8?B?Y0xhRG1iZzRMVXgrOUdyOVJEaGFneEU5SHh1NEhyZzlPa2lRZnJpb0hMeEZr?=
 =?utf-8?B?M3p1V0xkc3UxVTVkUmNBQi85UFprUXpLd1EyTFh0NlNRZndSS1BnYzJaKy91?=
 =?utf-8?B?U1BjY2JhMythTlRQOFMzbzEwK25DODZ1WFBYS25udVVLcnBPM1JrbzZhVkpU?=
 =?utf-8?B?bnhKb3lvaUpjdUpsQkVTTkVVYmU0U3NHN1RmTXdXTy9FWktNSWJhOVBOR0U0?=
 =?utf-8?B?NjI1MHI4Y2lCWWVlNzF5K081d211ZnYzSWdMb2pIVlplcnJuZWtRVnJRT2tw?=
 =?utf-8?B?blc2ejdtME9jNTc4TmVXQnpnSVJ2QUFseFRJeEtIekY3bDZnUlVOTzl3VU9w?=
 =?utf-8?B?d1J2enhHZnFDa0dZY0ZoeDdhSis4QmZ2bTRpTWFLS3VNdnRhcWFwZjJvVHlj?=
 =?utf-8?B?OEs3TlpEbVc4MU9uVzEzSXdDRlVmOTcyTnpWUVg4RFNsR1Zyd2NXTENDNDFB?=
 =?utf-8?B?ZlhMY3NaSWJtMDVSeVRoS29MNnhGOFFTai9VTW9OTVEyN0MzcnBSU1d6bWRy?=
 =?utf-8?B?Wnp5c1FLUWxPa0QrVUc5dEhtazRiMlZ2QUVSWVBYWk85aUJ1ZVhacWQ2Sm1p?=
 =?utf-8?B?QXhnZ2lNbXlEcUJoTGgyakpsNGFCcHdzd1pmOWo3dDhERmVVdi9WZUt0eVdC?=
 =?utf-8?B?S3Q3anVSdHRQRVorR09oRjB6N2Y2aTJSamFlZnpPN0NHcUFKWEVDdFo5dEQx?=
 =?utf-8?B?bU5SM2ZPVFdHbWh4RmwwSXE3SXdYTStzWjFWenpJRjk0c25VekYyUFVoSjBH?=
 =?utf-8?B?WVZScU9TeHZnSWV3enZXdm9zNHQ2cEhVU1BsWXJQU05zRXdwYjFQajV3QTBm?=
 =?utf-8?B?dlJjLzFlbmVWdkZ5YU1rWVJHcXZEZ2tZalIxTmpRamUxV29YNDc4eElBMDFE?=
 =?utf-8?B?U25QUWRad1pLOWVXQmJLbjk2R0xnY2N0M0JCM1ovMjRPZWlVd2R4S3F6c3JF?=
 =?utf-8?B?Tzc1d0pIbEVFNWZEVzhmTGlZUW5TenA0TS9wMTVMWE9uSFIxYjk0NVMzdzlL?=
 =?utf-8?B?VU1iK25UK2tYODdZcVBGQm0raFA0T3NOdHUrUmZ4VGQ2aUF2R20wZVZoMnZU?=
 =?utf-8?B?Q3VqRzIwN2x2RkV0VmZQbmlsa3hQcUplMU5VQ0U1MHdUanJVTFdkN016eCt0?=
 =?utf-8?B?R3RuRnJ0ejR2Q2RDK0pMZThoV3dQMDRHWkoxYXBlS3gvaC8vajc2QUpiMVVO?=
 =?utf-8?B?LzJjOGVqZWFJbVBsQVRFc1pQWi9iMS9kQzhWeGcyUjgvRjhWZzdlV3lGbHhL?=
 =?utf-8?B?cTl2MnBtWXJTK0dMc21rdW9qOFYxVGdyNWhhd2Z4ZFJBb2R5aHZ3bmlkdzlx?=
 =?utf-8?Q?tinNjvoN3Yv12GhokFHnLoXMLZsa515BSWznXBb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee8ac9a-be71-4c84-af64-08d98e361c94
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 10:42:10.9675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VX894IX9hdPwOhXEuVi1a7y4RjiQvMkMXWG2F+cl/GSoYQd5iay2thSak0SCL2BXwudJpRNOg95OYRhoBSw2zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------57A68FF4B94B70C9507F8BEC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/13/2021 3:22 AM, zhang wrote:
>
> Hi . Nirmoy
>
>
> If you let continue to unpin. this will  allways test a same va for gtt
>
> I think we should  rafresh calculate  the value n
>

Right, I guess then the test should only run till gart size.


Regards,

Nirmoy

>
> On 2021/10/12 20:10, Nirmoy Das wrote:
>> When gart size is < gtt size this test will fail with
>> -ENOMEM as we are not freeing gtt bo after each move test.
>> This is generally not an issue when gart size >= gtt size.
>>
>> Reported-by: zhang<botton_zhang@163.com>
>> Signed-off-by: Nirmoy Das<nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> index 909d830b513e..0cf2a560d673 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> @@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>>   
>>   		DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT offset 0x%llx\n",
>>   			 gart_addr - adev->gmc.gart_start);
>> -		continue;
>>   
>>   out_lclean_unpin:
>>   		amdgpu_bo_unpin(gtt_obj[i]);
>> @@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>>   		amdgpu_bo_unreserve(gtt_obj[i]);
>>   out_lclean_unref:
>>   		amdgpu_bo_unref(&gtt_obj[i]);
>> +		continue;
>>   out_lclean:
>>   		for (--i; i >= 0; --i) {
>>   			amdgpu_bo_unpin(gtt_obj[i]);

--------------57A68FF4B94B70C9507F8BEC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/13/2021 3:22 AM, zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2be293df-2656-c551-682e-b08955307c0b@163.com">
      
      <p>Hi . Nirmoy</p>
      <p><br>
      </p>
      <p>If you let continue to unpin. this will&nbsp; allways test a same va
        for gtt&nbsp;</p>
      <p>I think we should&nbsp; rafresh <span style="color: rgb(0, 0, 0);
          font-family: Tahoma, Verdana, 'Lucida Sans Unicode',
          sans-serif; font-size: 13px; font-style: normal;
          font-variant-caps: normal; font-weight: normal;
          letter-spacing: normal; orphans: auto; text-align: start;
          text-indent: 0px; text-transform: none; white-space: normal;
          widows: auto; word-spacing: 0px; -webkit-tap-highlight-color:
          rgba(0, 0, 0, 0.4); -webkit-text-stroke-width: 0px;
          background-color: rgb(254, 253, 235); display: inline
          !important; float: none;"></span>calculate&nbsp; the value n&nbsp; <br>
      </p>
    </blockquote>
    <p><br>
    </p>
    <p>Right, I guess then the test should only run till gart size.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Nirmoy<br>
    </p>
    <blockquote type="cite" cite="mid:2be293df-2656-c551-682e-b08955307c0b@163.com">
      <p> </p>
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2021/10/12 20:10, Nirmoy Das
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20211012121018.81693-1-nirmoy.das@amd.com">
        <pre class="moz-quote-pre" wrap="">When gart size is &lt; gtt size this test will fail with
-ENOMEM as we are not freeing gtt bo after each move test.
This is generally not an issue when gart size &gt;= gtt size.

Reported-by: zhang <a class="moz-txt-link-rfc2396E" href="mailto:botton_zhang@163.com" moz-do-not-send="true">&lt;botton_zhang@163.com&gt;</a>
Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com" moz-do-not-send="true">&lt;nirmoy.das@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 909d830b513e..0cf2a560d673 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -212,7 +212,6 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 
 		DRM_INFO(&quot;Tested GTT-&gt;VRAM and VRAM-&gt;GTT copy for GTT offset 0x%llx\n&quot;,
 			 gart_addr - adev-&gt;gmc.gart_start);
-		continue;
 
 out_lclean_unpin:
 		amdgpu_bo_unpin(gtt_obj[i]);
@@ -220,6 +219,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		amdgpu_bo_unreserve(gtt_obj[i]);
 out_lclean_unref:
 		amdgpu_bo_unref(&amp;gtt_obj[i]);
+		continue;
 out_lclean:
 		for (--i; i &gt;= 0; --i) {
 			amdgpu_bo_unpin(gtt_obj[i]);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------57A68FF4B94B70C9507F8BEC--
