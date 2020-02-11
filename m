Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CEBC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4945420675
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dwvf7rko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4945420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B07D6EE70;
	Tue, 11 Feb 2020 14:52:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7211F6EE70
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqHtWzhYFXNoW5GXLVpIK35SdoBpSm9HhqXovU/ZuQMKi3wHaEgEoJyPN8UYbfBnnZ5s1STJLaIQBi7SQ/pz1WlFwC4C2IvoZ5tv4B4vQf1Q7UcqM+747KPyYuQvEKvnesCAnHuBv4vknxMP/mvI6j9nRoOecLKMX6HltHFuwpsRYtnc2ZM5auD5Ykzv29GpB8dPrVZHtZ8g3+cVxtse7nNtcbL6vlBvpTNeGv9FRhLtT5+0vtLMpPOX2OHItEq8dEuVDkuxr+cs4UEe6SbsmI5U0OCv23lKKis5W02ufexhz4jHxWivEsRbYJrT8efRvZSiH9IkSqc+EJ/KKvXbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOmbVte8VMdI4c4lOtk3NnGHbngZb5fTuuZhqkU/KVg=;
 b=Tt/4VBRRyVn/LxlfwU8hrOfAVb89Frp6JWpZ7lB6DQ+em1Wx0l7J6n+giLniXNT6RAREAznPt9tMCorhh1JpAGeRJLgPumTwccm6rNEO1hFIIWf9IuXAHC5Dx5UJimFrn+FHDnAiFGRJiP/FB7F16srLpmbW66m91dD3t0y/byVaPCmI6lvTNrAWarvvygKNETU50WIeKcOKoWAmjqAp1rXRPcwA8rRlSdZ5vlNrXSjDlS4mbvqk6KRmNerMyB2FOjfQPbojhKSSwZg/y+nk9k+i4A3pvaMGgxmeSI8KpUrQh3TFhUZjsPlszjsO9RK0hgZb8h/1vRNCsMg3aMu9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOmbVte8VMdI4c4lOtk3NnGHbngZb5fTuuZhqkU/KVg=;
 b=dwvf7rko2dfRL/OKjlcXUBRxmedRqnul3g76TsISjPH2QtzjsqnmMCa95z/5rbMm44AC9TSJpQykGKrN58zjTw2abr7eG/nb4MCkuY5c/G4r0g2Ob7Km67Ab1tnaOGXk1syK4JBRemrvtJ5/E2ky/L7Jvi1ZQvTi3HBD3dGn79c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB1241.namprd12.prod.outlook.com (10.168.236.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Tue, 11 Feb 2020 14:52:17 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:52:17 +0000
Subject: Re: [RFC PATCH v2] drm/amdgpu: move ttm bo->offset to amdgpu_bo
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200211140656.3574-1-nirmoy.das@amd.com>
 <3bf68f81-2825-6b00-af9a-e073c3872384@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <8d4c19f0-9a07-096b-3402-48d82e9d1391@amd.com>
Date: Tue, 11 Feb 2020 15:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <3bf68f81-2825-6b00-af9a-e073c3872384@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0034.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::47) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f2b:9b00:46cb:968b:e998:10ca]
 (2003:c5:8f2b:9b00:46cb:968b:e998:10ca) by
 AM0PR06CA0034.eurprd06.prod.outlook.com (2603:10a6:208:ab::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 14:52:16 +0000
X-Originating-IP: [2003:c5:8f2b:9b00:46cb:968b:e998:10ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcda1d1e-df01-4b5e-10fc-08d7af01fd48
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:|DM5PR12MB1241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12412C60634C3307A2806C318B180@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(66476007)(66946007)(66556008)(36756003)(478600001)(2906002)(186003)(66574012)(33964004)(52116002)(53546011)(81166006)(31696002)(316002)(8936002)(8676002)(5660300002)(81156014)(6666004)(4326008)(110136005)(2616005)(16526019)(6486002)(31686004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1241;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0iNFU3OdwRN+ZNaBPlPZ+yanFexOVFiNQAy72ednoR+yjMjqyRd8CqNEynRa+5L6XmIMnRbI4utndlJ5rDxGgiafVMOr6RnCOeVjZ0YRtxlNaVNP+6H6JMsKWvjNr00OQgX8KOfHFQlneANHSyr95R0q+uOfM8SsmAVYI053kPH9D/pHnQ6GOHh45Vy7ohKCXaLUcFJPuuc3neUdRKWZ2e9GwPpvrnAuL7gOwG9TUPpVDDsRII1ZRqFYCbnvdR7PKP9pV8GHtj2b+k8wPWisSHc/FKh9wzLkz7FYGTvYP4T4iz9ZTUnJOcXwWJmV64wRINdvbUnxGGe9gfLcyyFaPtU9NcotiEpko1UeycILm+gtMbNbI0Pkrb3xNOBmfyayp97N4V/iG5NrbCPzcP+1F4c4xrTvAceR0AVKXSx1nJDxMqxQV6DCJuLYKhl74GD
X-MS-Exchange-AntiSpam-MessageData: 5+xD56sO0A3KmZc6mpuMD3w6nNN7r76WmChm67jd7c3tOh+m99UjtZkCzCfbI1hDr63z8BmjSaPuVlTYIqg0pPanCwgHQUBKQY/eY2/v06Xpo3uiPoo7KJNTMCebgGKmSiyX5MGvdMhzzC8gzjDQ2QbKQDK+CK2vPyS5wYWt+MBty1uskQWyLOqep05zkoHajIJuPhZsNkIfaQrbiVjJww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcda1d1e-df01-4b5e-10fc-08d7af01fd48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 14:52:17.6560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4TMghOCAO012oXKkkW//BKVP3juCJ2XpzUpdSgXrt6w5eE3tAxbDNz7E5PdtMvm2uoziziG5/ZmtK5kE4zsOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com
Content-Type: multipart/mixed; boundary="===============1887189590=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1887189590==
Content-Type: multipart/alternative;
 boundary="------------D7601683C7E2E517AC4597E4"
Content-Language: en-US

--------------D7601683C7E2E517AC4597E4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/11/20 3:09 PM, Christian König wrote:
> Am 11.02.20 um 15:06 schrieb Nirmoy Das:
>> GPU address should belong to driver not in memory management.
>> This patch moves ttm bo.offset and gpu_offset calculation to amdgpu 
>> driver.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 +++++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 +-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 ++--
>>   4 files changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 6f60a581e3ba..e25924be33ca 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>> *bo, u32 domain,
>>           bo->pin_count++;
>>             if (max_offset != 0) {
>> -            u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
>> +            u64 domain_start = amdgpu_bo_gpu_start(adev, mem_type);
>>               WARN_ON_ONCE(max_offset <
>>                        (amdgpu_bo_gpu_offset(bo) - domain_start));
>>           }
>> @@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo 
>> *bo, void *buffer,
>>       return 0;
>>   }
>>   +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t 
>> type)
>
> Probably better to put that into amdgpu_ttm.[ch] or amdgpu_gmc.[ch] 
> and name it an amdgpu_ttm_domain_start.
>
>> +{
>> +    switch(type) {
>> +        case TTM_PL_TT:
>
> Coding style here is of, what editor and setting do you use?
vi with *set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab cindent*


My bad, I didn't check existing switch style.


Regards,

Nirmoy


--------------D7601683C7E2E517AC4597E4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2/11/20 3:09 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3bf68f81-2825-6b00-af9a-e073c3872384@amd.com">Am
      11.02.20 um 15:06 schrieb Nirmoy Das:
      <br>
      <blockquote type="cite">GPU address should belong to driver not in
        memory management.
        <br>
        This patch moves ttm bo.offset and gpu_offset calculation to
        amdgpu driver.
        <br>
        <br>
        Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com">&lt;nirmoy.das@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c&nbsp; | 22
        &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h&nbsp; |&nbsp; 1 &#43;
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 &#43;-------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |&nbsp; 4 &#43;&#43;--
        <br>
        &nbsp; 4 files changed, 24 insertions(&#43;), 11 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
        <br>
        index 6f60a581e3ba..e25924be33ca 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
        <br>
        &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
        <br>
        @@ -917,7 &#43;917,7 @@ int amdgpu_bo_pin_restricted(struct
        amdgpu_bo *bo, u32 domain,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;pin_count&#43;&#43;;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_offset != 0) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 domain_start =
        bo-&gt;tbo.bdev-&gt;man[mem_type].gpu_offset;
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 domain_start = amdgpu_bo_gpu_start(adev,
        mem_type);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(max_offset &lt;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bo_gpu_offset(bo) -
        domain_start));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        @@ -1248,6 &#43;1248,18 @@ int amdgpu_bo_get_metadata(struct
        amdgpu_bo *bo, void *buffer,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; &#43;uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev,
        uint32_t type)
        <br>
      </blockquote>
      <br>
      Probably better to put that into amdgpu_ttm.[ch] or
      amdgpu_gmc.[ch] and name it an amdgpu_ttm_domain_start.
      <br>
      <br>
      <blockquote type="cite">&#43;{
        <br>
        &#43;&nbsp;&nbsp;&nbsp; switch(type) {
        <br>
        &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TTM_PL_TT:
        <br>
      </blockquote>
      <br>
      Coding style here is of, what editor and setting do you use?
      <br>
    </blockquote>
    vi with <b>set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
      cindent</b><br>
    <p><br>
    </p>
    <p>My bad, I didn't check existing switch style.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Nirmoy <br>
    </p>
  </body>
</html>

--------------D7601683C7E2E517AC4597E4--

--===============1887189590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1887189590==--
