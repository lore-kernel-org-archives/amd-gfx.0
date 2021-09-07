Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9537DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C8A610E8
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 17:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54C8A610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70DB6E0A2;
	Tue,  7 Sep 2021 17:22:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1DA6E0A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 17:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4sgCIZ+iUOg5yBqTiC8MFxtukolsKqHW+6bF3LAvSzstkag6re4R1bKudkkWS6MHtgezoYSejy1ISrxbquNiiGjgfRU8sMqulgeyktfdVuFh/KwkOJpflAhAdTpkNHIpv6H+hXJIfyqv83hM3s5FgDwHgVgD4KsJ3LfASq9hxkYYv1UTIB4zDXsMj6qjFi/TvIFIu4BMR8DeOkFDcGL+T0oQyg+zse2jZf9+XSgeAdBpri1MBnANGEDqFfe3p9LeQsT9TKpW82CQ+Coib1cO1l3cPGnU1C+TPq3q/5IiS4YoC4FVnw4OSAAtWXU54UklPd3sreU9QH2uuH3z8kCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SnUY1aeU3yP/VS5X3BuYuS+w1xieNnTbbnEmF2UNaao=;
 b=HNOzeIQqjIISd1y2yiZB1kFIe4uVG/MAEK0f/ozPOsctQWasul3xAz675eICq2B1YbgH0e7WkIZpRZmkql7pqjyAqtiBSquAf/2ul78i5Q2apidsk4xyQ1hhmSw3UtvdGLdfr/Qo+/tH+oF2DvQyXuUn63NbXSF/9mzQH4HxLjyceo4Yze4ErG2uRyb6hPdo/Jd/R46IsjuMowNyzxPEXEOs3hehFbqWjVRwkgX5u7ASodXHDBnMZnd5WhFbJZpOc3JaGQPVoQsub3ZTLHCUZIf01SgkPoOvCjGwt1hAklsSKonn2PXAHzhbG1dPGvgUQMz2xhSxx+Wz1Iz+XpUsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnUY1aeU3yP/VS5X3BuYuS+w1xieNnTbbnEmF2UNaao=;
 b=HwMFHJPF9LSyWtk8+uCa/cMNIPannRLFS1LzkiBBMNljdZiSB4gcOyDpGp4u5wZaNANwWCx7B1BDPZHBuhSyaczCmDikEyOvK3GHnxpE6i0WdPOOchi7qGGUUSNbAHZJh0GjB6d61ASBS7Q8/wQs0Qet0Sn/TUx+7BPfJu1jbzE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4729.namprd12.prod.outlook.com (2603:10b6:5:7f::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Tue, 7 Sep 2021 17:22:18 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::e1d2:cc87:74b9:397d%7]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 17:22:18 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: kolAflash@kolahilft.de, me@jeromec.com, alexdeucher@gmail.com,
 ted437@gmail.com
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
 <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <adfed1a3-4e1d-8ead-bbf4-4c4448c0f7fe@amd.com>
Date: Tue, 7 Sep 2021 13:22:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
Content-Type: multipart/alternative;
 boundary="------------659BAF423314CB7C41B765CF"
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::29) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 YTOPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25 via Frontend
 Transport; Tue, 7 Sep 2021 17:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533cb014-71e8-4d4e-c8c7-08d972240b3d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4729A26555797D4A5E5D61B4E4D39@DM6PR12MB4729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1cQk0k9oC5KQB9wYl2100VrLYbknEZGuy8QnkolDPu4Gun8mproUVAlj0hFrGpPbIMboRjzkDz0DiBD3prIxmEpXGnR4PvaY4s6zyIMFg5c9/iRNXJFGg7tSv5Ggfv21PBu/bRRl319NJXPI00lnnaZG88djSQPcK2AV6VD/+RpZ5F/MoVi7soksXzKsFu31OAY/H3ZeJZ/3MviG2ALLuZf+bOOT9ovZzRr1vA60xaNnQ2AGC/nBPdFImRQ/BKfD31t4apQx6J/G555j76Hnop4oK6ZQOWpTgmnAvkl1A1JbdyXgx50++CTKR8ckHQXUevymv/dfiBhtTfuOV78Jyt2V5UCJJsrJpQbp1dNwHQS4g6KnOJ8+q3DdwjKC6+gEePg5T7r4idYc0XERs5ah/VcPxeUtTog+JLdvmB0KqjIgrF5UHPZ4AeVAt+XmxWDTFEZFq/7ztczHi/UdG2t+FHIcgQqLViivHmGssduV2UUyHA60urF+VivqPN+UrZfg5xV28VmHlFQy05BwMeQgtndxpYPk1HBZ8qgvUtI+t9DeguOZCegPpI50solnXXUcbTSb1v5slO99E7hjRaVRcjJ5E72KpKROMJCO5gUZp31W/oR2ollKjQ4qMTCer3Tqz7iMl5ubJx80c7Y6expvos+pvpgVcy6R0Z9wUXNRqcxEymPI64VG6i7oTk8FTjT9rCZ+o2SdvjKtUh29zZSH/2NRZ8kbgRA2FoeYxE4a4+ogYAptIaEcG28uYzSwWdPOeApvcEY/Q3JQ15zWIvoLPPbe6hL+Sq6MXFOhJhbskG4z7lorcDKhyFBSqCM1XJrmIaOte9/Nt90vyQuBfqGzK2epyebdZETvX7L7HEqguU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(2906002)(2616005)(31686004)(83380400001)(966005)(16576012)(508600001)(316002)(33964004)(110136005)(4326008)(38100700002)(36756003)(36916002)(38350700002)(186003)(5660300002)(26005)(31696002)(66946007)(8676002)(66476007)(66556008)(166002)(52116002)(6486002)(8936002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tlh6MEViN1JRN1MwUWFkRHdGbjdIY01OYkYydVlqbDF4ei9xbWRhUVUyQlQ3?=
 =?utf-8?B?RDBZbjR4dWo4NFpKSy9SYitMVTZ0cFRRdkJQU1VYcmtqVERKdWMrNXZidFZz?=
 =?utf-8?B?KzROQUp2TGRQN20yZ2p0UFFDUHZRa3RQYThsdjFYM2JlbFpoblljT04zQ1pM?=
 =?utf-8?B?TkVnS3VWbHpVTFVpeWN6L2JnVmtyWHlVV1J6MU9CSVdNT21yWVk4K2FmNzV0?=
 =?utf-8?B?REhWaDl0cS83a0I5dUkrcXcvdG5KNDBzSmpvTDh2TkxqNjFSQjhyUkJkQTIw?=
 =?utf-8?B?Y2FGTjN2NkVvRWg2MVVwcEpldGh3RlNoZGtYbm5leGxlOHdCZlIrSkFPV1BH?=
 =?utf-8?B?ZXlrUFc2N3JaZ3NTNVJlU1NGV0NsdWdNWTBLT0NieHVaYWJMcjBHclVBTUh2?=
 =?utf-8?B?RzJobWxpSGQ4SDRjdzFqazFCQkV2TXJzdytRTW1oNzhIdk83L0gxZWRsMHBF?=
 =?utf-8?B?Nkl4UXdZZlNNUW9FeEU3UWVNZXBFUGJHNWZkUlBpQjUzMHZBaUhYKzRPUkJz?=
 =?utf-8?B?N0YrU3RqTkFqNGFVZkxXQzljNXZoTmFlOCthVW14N2drRzJXQU5xa2ZyUjlm?=
 =?utf-8?B?bU43T2NxTVVud0VPYVo0clNLSVFMeW1LTW9qM1RuR2NWd0VVS3RRVXBEWXJ2?=
 =?utf-8?B?d2dVYnVyM1FJczd4RHlXSGhLWnFlZHdxV0ZvUjl3OTBQVjk0b0lZSXgyQnJW?=
 =?utf-8?B?ZUhWclo4bW8wM20welhJQVVMZVVJa2NjTjNmTmJleFpqaEx5QytkUDBVQ1ZY?=
 =?utf-8?B?TFRCNlYzRTJxUDJCL1F1VlQvYUdzRG9YMU1FQVhxWE5iTnhxSnZJakFZRldB?=
 =?utf-8?B?LzZ0VytTdWlLemZwWlBOSUFBajRGWmxWSklIcTg1Wit5SmxlL0VxUjdvdlRS?=
 =?utf-8?B?YkVCRnhncFVodUJaVDFBc0FhL3o4NUNuZUJ1Q296K2VSV3UxVmpZR1pDUkFy?=
 =?utf-8?B?TjdBUzVhTGUwbnZ6QVUrZzE3Yk5BOXhYYnF4Y3B1SmcyWlhDeXdzQWxValZK?=
 =?utf-8?B?SFpUeU1WK1drdHRsVEh6M2N2MDRMMStMYnRlVWxxWTR1YWRtNElBTFV2aG1z?=
 =?utf-8?B?OHBCUDM0ZXZBNmttSXBBaExOUDJnZy9leVJyNlpGWGRsTVNSZllLOGhEaE9k?=
 =?utf-8?B?NlRPMnU1d214SVhMRVozcVhCQTllSWFEaXpLVjlNZk13bG5lYktGRnNXNkp4?=
 =?utf-8?B?U0lmTHBPQU9EUERMSk9QaE5oMHlBRWFWTXZjOHE4VnF4S2VmMTVtVkYyVGNF?=
 =?utf-8?B?S2diNWd0NHI0NGo5QUhxUzVHa2dSSndoRFRRWkdZUEk0UkFqdTdWZzJTd2J0?=
 =?utf-8?B?Mko3ZUlTb0k0ZkZKQlcvNDBhMTlEVko3aWJEdVJibXR0SDVqVTlEaTdUZnlI?=
 =?utf-8?B?bE9HL29PTVdCMk1MU0YzdjdvRnIyVWRaREgwNWJncng4elZaUDhzY3Y1OVd4?=
 =?utf-8?B?U041c3N4SGh5dkdBZTlRQTJKSDhzbGd5OVNaZWVFMWROL1BtblpnSlQ4UDVU?=
 =?utf-8?B?Ny9WcXZ2MUxvUVFCaVFHVlc2RkMzSHI3OWJIdkkrdVRDNllnMmorZlQwSUY2?=
 =?utf-8?B?SHJPdFhsaGdVb2dWYkR6S2RtNG5oZmdodE0zY1M2V3V3UzgzZFRPUjZpbEd1?=
 =?utf-8?B?a2Y3djVGWXZyMmw3cnNKYmEvRWlkNzd2L0dwTW96NXNwclUzenI5eDlScGdp?=
 =?utf-8?B?b2J2enVESGN3T25qbmJsQS9yVmZLNElmSHpzc1BGenpkNld6NVBtLzNscjJj?=
 =?utf-8?Q?fBU6onosXP12dRhES7uC0zUP77WRhjsLyD1ajAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533cb014-71e8-4d4e-c8c7-08d972240b3d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 17:22:18.3552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH0sgGSgVa0rPzqgiI2M1+P2tJOf0z8dtqY9VnSlKi3Lf/Z06IEefnJXBSUvJBC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4729
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

--------------659BAF423314CB7C41B765CF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2021-09-07 12:48 p.m., Felix Kuehling wrote:
> Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
>> Separate iommu_resume from kfd_resume, and move it before
>> other amdgpu ip init/resume.
>>
>> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
> I think the change is OK. But I don't understand how the IOMMUv2
> initialization sequence could affect a crash in DM. The display should
> not depend on IOMMUv2 at all. What am I missing?

[JZ] It is a weird issue. disable VCN IP block or disable gpu_off 
feature, or set pci=noats, all

can fix DM crash. Also the issue occurred quite random, some time after 
few suspend/resume cycle,

some times after few hundreds S/R cycles. the maximum that I saw is 2422 
S/R cycles.

But every time DM crash, I can see one or two iommu errors ahead:

*AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=**** 
flags=0x0070]*
Since we can't stop HW/FW/SW right the way after IO page fault detected, 
so I can't tell which part try to access
system memory through IOMMU.

But after moving IOMMU device init before other amdgpu IP init/resume, 
the DM crash /IOMMU page fault issues are gone.

Those patches can't directly explain why the issue fixed, but this new 
sequence makes more sense to me.

Can I have you RB on those patches?

Thanks!
James

>
> Regards,
>    Felix
>
>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 653bd8f..e3f0308 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>>   	if (r)
>>   		goto init_failed;
>>   
>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>> +	if (r)
>> +		goto init_failed;
>> +
>>   	r = amdgpu_device_ip_hw_init_phase1(adev);
>>   	if (r)
>>   		goto init_failed;
>> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>>   {
>>   	int r;
>>   
>> +	r = amdgpu_amdkfd_resume_iommu(adev);
>> +	if (r)
>> +		return r;
>> +
>>   	r = amdgpu_device_ip_resume_phase1(adev);
>>   	if (r)
>>   		return r;
>> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>   				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>   			} else {
>>   				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
>> +				if (r)
>> +					goto out;
>> +
>>   				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>   				if (r)
>>   					goto out;

--------------659BAF423314CB7C41B765CF
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-09-07 12:48 p.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Separate iommu_resume from kfd_resume, and move it before
other amdgpu ip init/resume.

Fixed Bugzilla: <a class="moz-txt-link-freetext" href="https://bugzilla.kernel.org/show_bug.cgi?id=211277">https://bugzilla.kernel.org/show_bug.cgi?id=211277</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">I think the change is OK. But I don't understand how the IOMMUv2
initialization sequence could affect a crash in DM. The display should
not depend on IOMMUv2 at all. What am I missing?</pre>
    </blockquote>
    <p>[JZ] It is a weird issue. disable VCN IP block or disable gpu_off
      feature, or set pci=noats, all</p>
    <p>can fix DM crash. Also the issue occurred quite random, some time
      after few suspend/resume cycle,</p>
    <p>some times after few hundreds S/R cycles. the maximum that I saw
      is 2422 S/R cycles.</p>
    <p>But every time DM crash, I can see one or two iommu errors ahead:<br>
    </p>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      letter-spacing: normal; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; word-spacing: 0px;"><b>AMD-Vi:
        Event logged [IO_PAGE_FAULT domain=0x0000 address=****
        flags=0x0070]</b></div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">Since we can't stop HW/FW/SW right the way
      after IO page fault detected, so I can't tell which part try to
      access</div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">system memory through IOMMU.</div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;"><br>
    </div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">But after moving IOMMU device init before
      other amdgpu IP init/resume, the DM crash /IOMMU page fault issues
      are gone.</div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;"><br>
    </div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">Those patches can't directly explain why the
      issue fixed, but this new sequence makes more sense to me.</div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;"><br>
    </div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">Can I have you RB on those patches?<br>
    </div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;"><br>
    </div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">Thanks!</div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;">James<br>
    </div>
    <div style="box-sizing: border-box; font-family: &quot;Segoe
      UI&quot;, system-ui, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;, sans-serif; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      word-spacing: 0px;"><br>
    </div>
    <blockquote type="cite" cite="mid:03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 653bd8f..e3f0308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 {
 	int r;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		return r;
+
 	r = amdgpu_device_ip_resume_phase1(adev);
 	if (r)
 		return r;
@@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				dev_warn(tmp_adev-&gt;dev, &quot;asic atom init failed!&quot;);
 			} else {
 				dev_info(tmp_adev-&gt;dev, &quot;GPU reset succeeded, trying to resume\n&quot;);
+				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
+				if (r)
+					goto out;
+
 				r = amdgpu_device_ip_resume_phase1(tmp_adev);
 				if (r)
 					goto out;
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------659BAF423314CB7C41B765CF--
