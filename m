Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EADEC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197BE61108
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 197BE61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93936E40D;
	Tue,  5 Oct 2021 15:13:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE886E40D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 15:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GthkcW9Vx7awqsG4lIqBdLSCyWwd3rIoRqFpi2fGBn/YlezdPyC8Mm7X0cUTCvNTl1Pz0wCWcNgLk90s5gtxdRwxOiAbnlaPYpclp5IK7Bmj1NIDGtbG9wBJ5++68Y62SJim5xH5mrxfo8sWjwmpmFRVtjlbi1ECJDwz8oeKYPq8dD1712TzhVKhHMeiInQxSjHomTbh5hC8CoPFnRXQNogwSBeYHtXkMFxWlbdgSXhPyarK5775Kcu2ofeoisIZbZ1vrztOomNwzJXRsEzCHnCmlSzrbILV1tLBvLOenmqaxuzCd+3fG7leUJxqUJW+3fX6k0Gj8KjJ3VxC8JiHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlGd2xRRJ+yqhzilKyMr9XZ9ckZjAPzte77GAA2aWQw=;
 b=KIgCZeTUS9xhd0PORASrPp9twK19fiwXwWk/VXzV0lMYIfGPjKrkdIFagwC2AZuwov+MjoP7K0lVab063IiFl1zydl0UJeNBtIiPGuBW3Lb5qyvom+hrfEJFbOqcuXvTip8K9Fuxl5F2RLOqB7r4SO6eBZkTeVC+KHHA2Hub5PLQrn2vFaxg4FWcQ0Je9vXLsGefAOiovqtH/YOOFQ6nXSmrbQKQd/p7vMmbNKRmL5P0gv5sWHxRZrhvw3/a5uExR37cs+7lYdp+4nsJAxDAVY4arVZviPCf9cs2tRy1yQKzGF0kI8im1Ob6+N7lNkF2+K+gFJSn7pBsVM+YMjyEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlGd2xRRJ+yqhzilKyMr9XZ9ckZjAPzte77GAA2aWQw=;
 b=p0HkxUTUjGE2ZysxCjLtx7C4erapB7IN+J02V6SNOCEhsb4dmJK42MV1vYow11q6hIIek7ZNvyEpRgHjft23k3ap45F5CMx9AfwQ9pWFTWUjO/bDnC7f2YnjgbCRiNGy2FD5k1yJ2L+gb0TaS5sXs3WI3t3O2jksulDsEdZ8Zls=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 15:13:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 15:13:48 +0000
Message-ID: <fa247d57-168a-4d92-494c-b56db8fbd6cf@amd.com>
Date: Tue, 5 Oct 2021 11:13:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 01/23] drm/amd/display: Update link encoder object
 creation.
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-2-Wayne.Lin@amd.com>
 <acfe099d-b13b-2975-8ac1-8f0d9e2ddd28@amd.com>
In-Reply-To: <acfe099d-b13b-2975-8ac1-8f0d9e2ddd28@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:408:f4::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22 via Frontend Transport; Tue, 5 Oct 2021 15:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 126f11dd-220a-4947-d2cc-08d98812bb47
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54272AE2952417CB7A30FE418CAF9@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3f4SeOUvL0fRDoehD/hq0h5oS5V17mdG1kuzusQ0r26lvJFCZ0a32S5ikKWIkudObKHwIVQ9z0I3e/R79spIPf9fM/w8d+q22prC69wDWnJZLf1DuDzFMPk1m9aEbbKmUZbPlGgbhHfVp2lnW8cb6aOALX5pL9LG9b/IFRhfyuERtI1qK5CQXFgtcRNHP2z4Z/YziDxwvficu2kD2ttjpNyDkVGbZ2zBZk5bS6Dq7mx1z9snEoKzB4IP3eRyPEvdCj14Fof+OQa6u5PGF4sRcHT96FFTa4/TNQS0IxyuQeXgtns3EjzDSuyHJ1G+YqLFQQMufbVpqJWTYfpbweqfXaDeZC9FOs5eiwYIZbw4gYnvS17z5KphWnIi0w85aMhSU+EknASHFQ2Sob8D05Ub1ug8TM0JDctlqfh6ObJh3lpTopaWt0wXDWSgbrtiP+dhvnLd8tWQ7pqZ+EkWm49CEn9wbrSX4OsGW4MNazKmWqKyoYvh1U/X/K8FDip8xoXf06CgLjwuDgqnSqEpBJ/aZml0gm0iATay5uUFnnY/ucrrM0m1viOxxV0h23zIzAkwdoagI9RxWMgU4fGuvKhto538L9R5u5xiA4FBzioRjAlB/J5uiGlLrHUQjsCI/Ugh/GfNa+lYttNBc9LJWXRkxyuk3k5oFxYu+pfbhmkkY4uZGHyti+SvGpTE4fygP8Yc06MHmGUQPj8OjzJfP0Cz3gDdGU17I9BCuSVgPPUdPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(508600001)(8676002)(86362001)(66946007)(66476007)(66556008)(44832011)(53546011)(83380400001)(5660300002)(2906002)(6666004)(15650500001)(956004)(2616005)(38100700002)(26005)(6486002)(31686004)(36756003)(8936002)(4326008)(16576012)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZxY3MxbmFwSXUxOThkNXlYc3hOTko3eGQ3VW9ISERvdURldFhaR2NYZFNn?=
 =?utf-8?B?V25zNlNUVS9CWEJ1M1ZIQU9jdUJjaE1McUdVZ0xJaVRvN0RQa2gxWG9XOGVO?=
 =?utf-8?B?K2pwUTE4OHFGbFcwTjBBVkY0K0RJQzhOSklKM1BPd1ZxSjgzUm5LNVpuaTho?=
 =?utf-8?B?cGpmcWJpTjFRdkhKWFVWMFp0WkV0Q2lzbS9YM0NvdUprQzRWQTNaUjExbjNt?=
 =?utf-8?B?TG01b3BWRUpuOS9qSW0xeDdvOUxuMVZUcHdnUDhJWVZidWs1dm42NmRKVXA0?=
 =?utf-8?B?UUlGa3QrQXJxRTZhd0hTS0F1V25oQmFlRzV0QUhHVnUwMkt6TFh1VHhBZW9u?=
 =?utf-8?B?Qks4V3BzREpINHFGT09ITHpCc3FHK05QM2lkWG5WRTFqU1NrMlJ5Q1UwYWxm?=
 =?utf-8?B?TDlQQytUanZNSEhKc0x0L2ZJTDNhOXhtaU1ubXFVbU4wSkpDNVY0YmlnbXg0?=
 =?utf-8?B?UmM0WEdSZ3ZQamYxNng0cUg5K1oxbytHTndjOFhBODNIa2hEc0RDVVVGaVJ5?=
 =?utf-8?B?WXRNdk4xV005dWdkcldHUTNnM3VQdzdXcmhOUkhLbHNnWThZWDc5bElrYUFH?=
 =?utf-8?B?K0VValJNdjNCRkozQngwUHpvQmRySjJpemFibjJNOExHYkw4TWdCZjNBT0xS?=
 =?utf-8?B?WEdzSkl1YVhnQWhXbXlnVWROL2t2MlNoZHJDSUJqcmExQy9nUVhCaFJ3Zlpw?=
 =?utf-8?B?WHJaeUhycEJGN1JCVjNXQ2tlby9XRExuWFRZWjlXVGR3OHZmeTUrcjExaGFE?=
 =?utf-8?B?TURqeFNWd3BSVUdqZjBXZmk0UjFCZ01YSG1kZlRTS1dvQWlYTWgrdkRKa1V1?=
 =?utf-8?B?ZzlkeGdONWZ4a2hiWGRhUUkvNzE4anVjbWs5Y2E0UXhWS0VtZlRDQnhpVVVn?=
 =?utf-8?B?OWVteS8zT0ZSY0JwZUZGcXlzRGJveTdMb2k2N01rQ0hhbDdXc1JxWjdqUFNy?=
 =?utf-8?B?SU84NWhTZEdYcVRLa1dqeXpnMnp1cDVJbng1SGNLTXBnQ3ZadHRsVnJrdGhm?=
 =?utf-8?B?MFlkYTdrR1pYMmZJTzM3SlFNWnJTamFSR2xLUDlkTFErN29qRHFBbzNjMzRo?=
 =?utf-8?B?KzFTRGRGbXRPUS92akVWVnk0NW0wUWlCTzZOSng1OXg2VDJETnk4cXJBcU1B?=
 =?utf-8?B?UjVOSHpjNW5KTXFQLzJPTUZieTJna1Q0aDEvcVZNaUJoUTB6QjA5WVZvc2Za?=
 =?utf-8?B?ZzkvVjFjYkc4REFrRTYvUUxyMmQ4VkFvVlZyei9mMmljbUhmQmVOSzU4Qk1V?=
 =?utf-8?B?TGhDMXVWOFdnbTBabzZmMkFwL0RUeWZJeGRWejJKMFNRY1lmUVBNQ3A0aU9a?=
 =?utf-8?B?RVdzRzR4N2cyc0lwL1FuanlaVmVFa2NtU1VIZlJ1YXZuOVl3bFV4Mk4vUjln?=
 =?utf-8?B?cnlWZmtqVzBPTVM5NW9CUmV3Y21CUVhjQ0pma0VFVHpOK0tXdkh6YTR2Q3U2?=
 =?utf-8?B?WW9YbnBIOTZqV09nUC9zTUpyVEVWRFg4ZXoveThyL2dCbk91eWxUUjNITWZi?=
 =?utf-8?B?MUtvTWdVOG9Sa00xRFRscWppZ2VKemVwTUtTVnhnT0RXUlB1R2NYOWRMVFJt?=
 =?utf-8?B?d1VNTUV1ZW9HNFVGUEVMYWdBZHcweFkvRThsN1YwNHNTYkdiWUNSdW81SkFK?=
 =?utf-8?B?dmVZdTlSbTBPcGd3ZEJwRUdDNFFyRGk5bzgrZk5SK0kyNmErdTZmSXh6bHpS?=
 =?utf-8?B?NXNyMUNTZEEvTzB6NlpDaEhZNmc4bWFiVFIxbTFNaHNhWGpCOEMxdmZiNStT?=
 =?utf-8?Q?QFHwBbJOsZIkNJbnzLceSH6XtIIyNQP91vAPGHt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126f11dd-220a-4947-d2cc-08d98812bb47
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:13:48.4790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ESzIIULAsD/qwG8f9eODuM4s4wr8+xAjdd8jEpZSVaCxuoacZrWe98zOQBee02pK65vXVsMP6DTFQtqtMHSyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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



On 2021-10-05 10:15, Harry Wentland wrote:
> 
> 
> On 2021-10-05 03:51, Wayne Lin wrote:
>> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
>>
>> [Why & How]
>> Add codes for commit "e1f4328f22c0 drm/amd/display: Update link
>> encoder object creation" to support USB4 DP tunneling feature
>>
> 
> It looks like all of Jimmy's patches refer to porting code from some other
> patches. Do those patches have a patch description?
> 
> Basically, above "Why & How" description doesn't describe why this
> change is made and how it is done. Please provide that description.
> 
> Same with other patches in this set that talk about "Add codes..."
> without providing an actual description.
> 

A decent description for this would be something like this (note
that I'm not a USB4 expert, so keeping this purposely high-level):
"USB4 endpoints are dynamically mapped. We create additional link
encoders for USB4 use when DC is created and destroy them when DC
is destructed."

Harry

> Harry
> 
>> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
>> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
>> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 77 +++++++++++++++++++
>>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
>>  drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
>>  3 files changed, 80 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index 8e0bcd4fd000..673fb0ef7a89 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -296,6 +296,75 @@ static bool create_links(
>>  	return false;
>>  }
>>  
>> +/* Create additional DIG link encoder objects if fewer than the platform
>> + * supports were created during link construction. This can happen if the
>> + * number of physical connectors is less than the number of DIGs.
>> + */
>> +static bool create_link_encoders(struct dc *dc)
>> +{
>> +	bool res = true;
>> +	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
>> +	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
>> +	int i;
>> +
>> +	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
>> +	 * link encoders and physical display endpoints and does not require
>> +	 * additional link encoder objects.
>> +	 */
>> +	if (num_usb4_dpia == 0)
>> +		return res;
>> +
>> +	/* Create as many link encoder objects as the platform supports. DPIA
>> +	 * endpoints can be programmably mapped to any DIG.
>> +	 */
>> +	if (num_dig_link_enc > dc->res_pool->dig_link_enc_count) {
>> +		for (i = 0; i < num_dig_link_enc; i++) {
>> +			struct link_encoder *link_enc = dc->res_pool->link_encoders[i];
>> +
>> +			if (!link_enc && dc->res_pool->funcs->link_enc_create_minimal) {
>> +				link_enc = dc->res_pool->funcs->link_enc_create_minimal(dc->ctx,
>> +						(enum engine_id)(ENGINE_ID_DIGA + i));
>> +				if (link_enc) {
>> +					dc->res_pool->link_encoders[i] = link_enc;
>> +					dc->res_pool->dig_link_enc_count++;
>> +				} else {
>> +					res = false;
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +	return res;
>> +}
>> +
>> +/* Destroy any additional DIG link encoder objects created by
>> + * create_link_encoders().
>> + * NB: Must only be called after destroy_links().
>> + */
>> +static void destroy_link_encoders(struct dc *dc)
>> +{
>> +	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
>> +	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
>> +	int i;
>> +
>> +	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
>> +	 * link encoders and physical display endpoints and does not require
>> +	 * additional link encoder objects.
>> +	 */
>> +	if (num_usb4_dpia == 0)
>> +		return;
>> +
>> +	for (i = 0; i < num_dig_link_enc; i++) {
>> +		struct link_encoder *link_enc = dc->res_pool->link_encoders[i];
>> +
>> +		if (link_enc) {
>> +			link_enc->funcs->destroy(&link_enc);
>> +			dc->res_pool->link_encoders[i] = NULL;
>> +			dc->res_pool->dig_link_enc_count--;
>> +		}
>> +	}
>> +}
>> +
>>  static struct dc_perf_trace *dc_perf_trace_create(void)
>>  {
>>  	return kzalloc(sizeof(struct dc_perf_trace), GFP_KERNEL);
>> @@ -729,6 +798,8 @@ static void dc_destruct(struct dc *dc)
>>  
>>  	destroy_links(dc);
>>  
>> +	destroy_link_encoders(dc);
>> +
>>  	if (dc->clk_mgr) {
>>  		dc_destroy_clk_mgr(dc->clk_mgr);
>>  		dc->clk_mgr = NULL;
>> @@ -933,6 +1004,12 @@ static bool dc_construct(struct dc *dc,
>>  	if (!create_links(dc, init_params->num_virtual_links))
>>  		goto fail;
>>  
>> +	/* Create additional DIG link encoder objects if fewer than the platform
>> +	 * supports were created during link construction.
>> +	 */
>> +	if (!create_link_encoders(dc))
>> +		goto fail;
>> +
>>  	/* Initialise DIG link encoder resource tracking variables. */
>>  	link_enc_cfg_init(dc, dc->current_state);
>>  
>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
>> index 0fea258c6db3..ed09af238911 100644
>> --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
>> +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
>> @@ -245,6 +245,8 @@ struct resource_pool {
>>  	 * entries in link_encoders array.
>>  	 */
>>  	unsigned int dig_link_enc_count;
>> +	/* Number of USB4 DPIA (DisplayPort Input Adapter) link objects created.*/
>> +	unsigned int usb4_dpia_count;
>>  
>>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>>  	unsigned int hpo_dp_stream_enc_count;
>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
>> index 3fbda9d7e257..372c0898facd 100644
>> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
>> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
>> @@ -49,6 +49,7 @@ struct resource_caps {
>>  	int num_vmid;
>>  	int num_dsc;
>>  	unsigned int num_dig_link_enc; // Total number of DIGs (digital encoders) in DIO (Display Input/Output).
>> +	unsigned int num_usb4_dpia; // Total number of USB4 DPIA (DisplayPort Input Adapters).
>>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>>  	int num_hpo_dp_stream_encoder;
>>  	int num_hpo_dp_link_encoder;
>>
> 

