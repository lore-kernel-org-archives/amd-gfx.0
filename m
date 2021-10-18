Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F80C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 17:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EB461212
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82EB461212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1834C6E874;
	Mon, 18 Oct 2021 17:14:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBCC56E874
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 17:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWBtDL9dIIJAR5kyMcK7RXeG16hHGFXaX0Xr/t/ntP1fS6lD46JIOvOfcpbqFfOZtK0meB7SpdKab569a8xEjjBu1NYfHjxo5eHv/e27wSF95oxcsk/uOkshsh7ZdEsHTIQPg28iirMBioOQAbpBTJRG0QaNa4aaEJjzppqe9SMKK87buxn15Enwukdv2L6ppXn0dYjRXbGZ1vYRvH3heHn5/0IKoOrypNLsqnxZ3Nvv8jzRfjGNC3N+FkDb2WiaUu6vWLjlSEuU9QCOgBct2dV8uSqKnz1r4DQ3e51/EOt8xK1/A64nIUFo8V+tfFC2NyZ4gqvfiJ/jJ7vohTL3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34q0nHm2HgGzqFqt3MzPt9jE2Ei5F7uR18B20Q2nfws=;
 b=NLxLM2+3uoCMpoyvKROMIe0DGbq+BWEO3nroJ4b+5dJaRQdRid8TTfp54JUpuIQSZSb4hVNUJ1bdwGC/1FWh/79zfaCM58nFDKEhlaTqJA9JRs07Y9e/FQKYiaKWS4l+V6GY3atln+lvO3BCCrLPgVZkRpptO19DheW79pUURQLP9FrgM5+SrORnVzO4FsjLiDVqocCOfRFQjyFU3Dz1rusnG5s1ZCBAyi+ZRdh5zfjBXp7aU/B+hyUHiaEJJ8nyvhsmqr+HuCfPWpuxKMiaqpCNi7+dOWxXxiRkujCjWAcDYPl0QkvlvIkO8Sa32JNCSUzmTzLIZL/+73qfW13fgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34q0nHm2HgGzqFqt3MzPt9jE2Ei5F7uR18B20Q2nfws=;
 b=a1ZDFsVezdA1tWWHVbuFLhO8Mhq+RIU5BzsARKx+54MweXCkREl+F2vcxr3gXUT4PdS/dsdWIfXJbSYRGmpgdXgX1xGCJI/ibPMl+Qt4ZFxoSG+yjfi3s9Vyfe4mFVKfMgK/l7f/MUMQ0od2SeutSzKoZf5gb8RUhrUSbKpsesc=
Authentication-Results: fireburn.co.uk; dkim=none (message not signed)
 header.d=none;fireburn.co.uk; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 17:14:35 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::3c90:18ad:1198:48c3%9]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 17:14:35 +0000
Message-ID: <3f1dee31-dfb0-3fb2-d647-9b6bf344a7e9@amd.com>
Date: Mon, 18 Oct 2021 13:14:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 16/27] drm/amd/display: increase Z9 latency to workaround
 underflow in Z9
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>,
 Agustin Gutierrez <agustin.gutierrez@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Harry Wentland <Harry.Wentland@amd.com>, Sunpeng.Li@amd.com,
 Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, qingqing.zhuo@amd.com,
 "Lipski, Mikita" <mikita.lipski@amd.com>, Roman Li <roman.li@amd.com>,
 Anson.Jacob@amd.com, Wayne Lin <wayne.lin@amd.com>, stylon.wang@amd.com,
 solomon.chiu@amd.com, pavle.kotarac@amd.com, Eric Yang <Eric.Yang2@amd.com>
References: <20211015184332.221091-1-agustin.gutierrez@amd.com>
 <20211015184332.221091-17-agustin.gutierrez@amd.com>
 <CAHbf0-HyA2EPHq74e_oq_X1bbSd9-uNwuX6aWYjf7Hz3UYTx3Q@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
In-Reply-To: <CAHbf0-HyA2EPHq74e_oq_X1bbSd9-uNwuX6aWYjf7Hz3UYTx3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 17:14:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff1df34-90f8-4e9d-1dbe-08d9925ac248
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5120C67E04471BEBA006B302ECBC9@DM4PR12MB5120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oS8XuyNK3orp9DIRsjCcoDn8kMINOcHFioSyTZ+3gC2B7rdBr3dz5U77Zms2XkHUcc1RnqM0MptxFC5JnMj3r1r/66CMqfhtjar/8T+MvMwvv1/5ehhmgfscfgDp58U8IWWP2/3NUQYMjVD0/9Gfz7tXs9TScjRXolEs/J9jfHjp8OEUs4bEWk0Bp8J1sKvQ5SetbidIlfWsg7nKaKKqLAMdoARgSmQNeGYZbgfhBh1LMBp5qDIMMOXqdpXC4WcpfJxowuwjaZIJiEHTAnyPM1YNEpxKu6052a8198VAVpxWMXygVawxvYvjWDnjcZcl+pd3p6XwTpcH90DQlljAVkBRBZvNG+KDbkyhbf85pfgX1c7vb8Jz5JmLyUXlfFnmgvFGAV7LdHOcKlNR7uuFEFidZPGZ2GtFC152vt+bLESgbFNvkreyjjXHXmgqgpcqDYwyEyj55Ekf+qm790W4llJHZOFQGbBEh3q7EzqPDJqdtq6H0HofA91iWNupw4Eap7T1oGUyTZIpyK/wYQRR8OV0TwS35684/YpnPhLid26baHccy4IIRlrrayfJZxzgEeDCNtltc9mTo8+d7SQe4bfYvclFKCeRYZ+rCHMPZPhNVtzwuuXO6AnUT8umFw53Yj+k9huQPH32+tQzuV0pI2bZYXgfTxaD2IPIWhtCGUdriE2cTYmxEGmhlvACHTFzyc/PdV5yJM+hV/WVnfipBAoLfbjGrT/vl/Vhx9ojNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(31696002)(16576012)(5660300002)(2906002)(66476007)(86362001)(66556008)(26005)(956004)(2616005)(83380400001)(8676002)(186003)(8936002)(6486002)(316002)(4326008)(6636002)(53546011)(31686004)(38100700002)(508600001)(6666004)(36756003)(54906003)(4001150100001)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekR4dHFZOGRvQjlybllsZ3pYUVJRajRoZzNXMjZ0WEZzNUdlTHJkaE0yUkhT?=
 =?utf-8?B?K0psUVd6dGtNaVRodVpoV0Q1ZGJHamMwQzUrSWNRejFOWHhTYjRlei84WVQz?=
 =?utf-8?B?Nm5CVUpmRjdDVVc1cnJUekpvcjREVTVaalA5Q2VYRlpsN2lmbjFXUEhPVnpN?=
 =?utf-8?B?UkdHTlpraWJqSE1nbS9zREZ0QzFLMU9TclJEUXc5TTl2MnFrOVJEUU4vWTVk?=
 =?utf-8?B?ZDg1NytxQ1VySXB6Y1gxM3FiQnpaQ0xPbjQrUW5CSTQ4eGFhVnNhZC94dWFt?=
 =?utf-8?B?SXJCcnc0SUR5ZDYwd1h6S1F6RVBzYmRtVUR0TTIrNmN3Q05Ib2xvSjlMRWY5?=
 =?utf-8?B?anA5R2lmcTk3NUNmeUpQK1RwUkY0bXdaTVNCV04rcVVscGRvbTkvUVdpYk12?=
 =?utf-8?B?RGxLVFdQekRQOTN4Nzdkd3JKRzJPNTh4OGpqdnpuajVzUXhBcWhlNUF2dlR2?=
 =?utf-8?B?MEwraEwxajRrUEdXNFRIQXFlYTJZWVpsZE9WY1JmMFdUSVhEalpEdlNLSTZx?=
 =?utf-8?B?TjBvLzVleGQ1blh2dnNSN0w5UnRuWVl0STNzL1A3QTFsbEkzYWVTdXo2R2wx?=
 =?utf-8?B?ZWxDZzFtNFM5cVZzb0VZWUpnWUpQTDF0aUdEUzJCOU45dlE5Sm9wRmpIUW9q?=
 =?utf-8?B?TVJxbXloWkV4akFLeEF2MEZCNjBzQk10YU53Tnc4b1dwaDRaQUREMkhqaG9U?=
 =?utf-8?B?SVZuSFNOOVNMc0NIZW9WbkJZLzNBV1FTRFNBcUZHa0h4TVUrMmp2c0NjbXc3?=
 =?utf-8?B?K3NTWDE2ZGY0MkdXU2JtR3p5M0xpbUN1dDlDWXZOTktsTUVIWUNwWmVSQW1J?=
 =?utf-8?B?ajJaZEVKQXZCREU0ZzZNSCtxUis4NW9QSS83RG9ZaHQ0V2l3c3dWQjZkTlcy?=
 =?utf-8?B?djErOW0vSENoeUt1N2IrS21LSEt1am54YXBKT3BFcmRja2FpWEt1OUw1NXZq?=
 =?utf-8?B?SkFzZWlCSVl3QUcvVlhvc2ZIckJsdGNweHdUOHZJUDRaODBNYkJUU2tvblh3?=
 =?utf-8?B?MkJQTnNVOVZHazE0T3BRSk5ndEtyZzB3VDNDVnNST2dVdHdudXJIWjFyWEt3?=
 =?utf-8?B?ejJRbTl2YktYdnRlQXluS3h5MTBRUlVsVGI2S0wwMnV1Mk9ZcGV3YzRJcWJI?=
 =?utf-8?B?VWFESnUrd1d5UnQ4d2VFbkYreHNDM1lNNkpDaUc4MFRMMnpEMDgrTXJVOG1a?=
 =?utf-8?B?bzl4OTl1ZmxWRlFsLzNqYnRxQ0RjQ2VRNVF6SWtuS2FHM2w0dWpiQmZLVGJa?=
 =?utf-8?B?b3pKdE0zdkprVkt2K2FtblJQdTc3QUFsa0JVMUF2NTBoaURzU3ZNV0N6MUc2?=
 =?utf-8?B?dEVBZjRCT1UxeFR5dVg4VXM5NzkyV1l3VVQvak9vUVhuTkdESTdCblZLZ2Zw?=
 =?utf-8?B?eXBtdkVBWGY4QmRONnVaZW8yNEUwT1FzS0RCSTF5bjhKd3NsOVlhczRUYWpz?=
 =?utf-8?B?WS9oQ1cxMTUrT05za2xhZXhzbVJLQjlSTnJhM0o5R1BYVWNhMG9nU2JIelVv?=
 =?utf-8?B?UjRMajZYOVBFQVlaVUZ0Y1lZckhRa0FsdUdrN2owYUpsRXI0dW1pdlgxTEhW?=
 =?utf-8?B?b3MvQSt5S3hLT0JBc3Ezb3YzSnMwUmxUZHNNRUd3LzBIam9wZG1WeG8xUjlS?=
 =?utf-8?B?ZHFPTWM0NnNWdHU5Nm1YR0luclVEamxxVmJrN25IRUFsYVh4WWZhcVZUaElx?=
 =?utf-8?B?VGlvOHhhc21SSXMxOVVIQitQelFJOXRFZDAxemRDSE0yQzhNd0U0RkRqL2tL?=
 =?utf-8?Q?t/OD03XAsTpK65YlgoS29C03qHVT84/jJn56ebw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff1df34-90f8-4e9d-1dbe-08d9925ac248
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 17:14:35.5855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7Q8PyjcKfK/PydUi4Jg+m+c0mjZewbNJqLTS7V7l0rU4SCQAtLeOkyeRn/OYchYAVOLYWtFX3mW225r6sjqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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

On 2021-10-15 7:53 p.m., Mike Lothian wrote:
> This patch seems to change z8 - not that I know what z8 or z9 are

It's a little misleading but the patch and terminology is correct.

Z9 is the usecase for these watermarks even if the calculation is shared 
with Z8/Z9.

Regards,
Nicholas Kazlauskas

> 
> On Fri, 15 Oct 2021 at 19:44, Agustin Gutierrez
> <agustin.gutierrez@amd.com> wrote:
>>
>> From: Eric Yang <Eric.Yang2@amd.com>
>>
>> [Why]
>> Z9 latency is higher than when we originally tuned the watermark
>> parameters, causing underflow. Increasing the value until the latency
>> issues is resolved.
>>
>> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>> Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
>> Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>> index c9d3d691f4c6..12ebd9f8912f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
>> @@ -222,8 +222,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
>>          .num_states = 5,
>>          .sr_exit_time_us = 9.0,
>>          .sr_enter_plus_exit_time_us = 11.0,
>> -       .sr_exit_z8_time_us = 402.0,
>> -       .sr_enter_plus_exit_z8_time_us = 520.0,
>> +       .sr_exit_z8_time_us = 442.0,
>> +       .sr_enter_plus_exit_z8_time_us = 560.0,
>>          .writeback_latency_us = 12.0,
>>          .dram_channel_width_bytes = 4,
>>          .round_trip_ping_latency_dcfclk_cycles = 106,
>> --
>> 2.25.1
>>

