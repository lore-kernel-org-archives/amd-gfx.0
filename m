Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAAAEB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 15:04:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B482310E5AB;
	Fri,  7 Jul 2023 15:04:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D9F10E5AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 15:04:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgN67IMJPg0tRypA5igMZk3g7IjtiECbVUOH76Ktx3Fs1JbVi6ZhxLsiHzl8G2hc+r3p4ovuDtRrYxM7k8nY/Ro/6/XKYBemDIovcLi3ZvL1mtN9YSKJ70GRhAiWoPX1xv2MnNP19LpbUj56qng36KA2FzTz/jEgjNTilvwrSzYnnvIjqWyx7TE94tY1DD/QpDZy1xtNU8o4XYKUc753fFIvWCwOJAdKPskRViPz8j0ptamo5dnAxPnZe3uDAi329YTM126Da/cYkmOj6hOuAbaCDjZ66+CajVsPNdJr5kaJQz1PUBXQAgKmBYYpADS7XAJlc1HtH6V6hpsS2r/6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUMPxqRXk4NhbybqFTzNhgi+HAOEIcDeJjy3tiAWgqc=;
 b=cWetPxYuAwG+51LLUVUx9hOYjkBQuRx2aM17ZvNJO475dMIgwx+qUNDNmk9vZYgC08xY55OPgI2yJ0SJNLrbgzgLSL24xBQCUka6X6l36Cg4MABBF2iL1HnjIZLsQkpym/jT0G/wki30SMpEzMLYXNiiopE8GHbBBAUSAX5YxGCJx3m5QXIkCH0TKx2RIjrHkYm2SWzFoTB/BJoRjW++hKjGQXxMIRKNmf52CC8wGIn/eV89yaDoJxVdmyN59Y6bvUlxBOueASF4y9aGKoVlQE6x1+LrMovOcWlOKP3om7cfqKsi9+XR7+4QecHqUvCjwrixmk2rmCaCen3h8Eyt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUMPxqRXk4NhbybqFTzNhgi+HAOEIcDeJjy3tiAWgqc=;
 b=Wvo/y1STVJbHhC4oxRwOKxRkDikdnSco8CGMP2kiTixP5DmiaNVMEhB8L3iGaZa4TatBCzbbcSsK6juQkfEhtYJYJnyS77xYj3tWrNr+kebqJjvC1du7ZkaQhnI3qLf5NQOY1ePHYHy8SoxRmRL7Qto2n6UtMxhIswaIo0/xAQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2576.namprd12.prod.outlook.com (2603:10b6:802:22::22)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:04:54 +0000
Received: from SN1PR12MB2576.namprd12.prod.outlook.com
 ([fe80::96a3:69f7:397b:5cf2]) by SN1PR12MB2576.namprd12.prod.outlook.com
 ([fe80::96a3:69f7:397b:5cf2%3]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 15:04:54 +0000
Message-ID: <5b902811-1b53-6890-e65b-07e94a4f58f0@amd.com>
Date: Fri, 7 Jul 2023 20:34:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] drm/amdgpu:update kernel vcn ring test
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, leo.liu@amd.com,
 veerabadhran.gopalakrishnan@amd.com, sathishkumar.sundararaju@amd.com
References: <20230706144720.3841607-1-saleemkhan.jamadar@amd.com>
 <8f6f65d5-13b3-0798-7e0b-df502dfca2ce@gmail.com>
Content-Language: en-US
From: Saleemkhan Jamadar <Saleemkhan.Jamadar@amd.com>
In-Reply-To: <8f6f65d5-13b3-0798-7e0b-df502dfca2ce@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To SN1PR12MB2576.namprd12.prod.outlook.com
 (2603:10b6:802:22::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2576:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1fa903-0ba3-4ef3-3623-08db7efb8560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4tJZR5CMGbaz4k4sCRtY5KKad8FlAlQRvDwhsnhfixJZ1cgbfQLHaRQ3qVDjxgMYL4vudUvxA5zuQZUKNRvuZKeyFSAwgJum/3K1Zg1sMN3gPdqjSPmrFMozG9bYeBJoJwQSbLIUWz5QsNT9k8kQrY0GUXw3LHb9gi33MB5ZWyAhvE1pqtbzciHyNvrwfuyjefPiIDXsxAV72q1CTS4HMb8pWMZG1pgnY1OQr2wf6/nIw6w+noF9A0pMLzqHnHiOwlFR9smDIYH0y9yj0msysrgx9GttsbFsBmZ2XQFrBLZXC5AOaWQH+HXvas08bZEU6ySMz7K+6hbUMmY0NBy++klVWDVY2kRB1+wlU9oAUX46MiMN8+OTvTyp6YTErd2B13CY/mvRiVjjD955oM29DRRI8m6FbjkfNMEOp3VQKDs/i64AtdGDC6GToZw/XtCqKUDVRj/AI6vwKXduUZxGUpxlJEI2AB19Xuxm1Bahxk8Aacpx4TZ5fccTKVZZsY/lFC8jitQbJVIXcGnl3N7vAcuK1cFnLP8h1AcgV2bavlDPu4tF9B9kLpP3K7N6tiCUm0f6edmAaMjUwCqzjHQvkOb6q957FCg2UCOzy2EFrNfOcvCT6BXpxRXeGCM7/jDXoCVl+pJPcdgBkq07clQww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2576.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(41300700001)(6512007)(478600001)(31696002)(316002)(86362001)(83380400001)(38100700002)(6666004)(6486002)(66476007)(66946007)(4326008)(36756003)(6636002)(2906002)(2616005)(8936002)(66556008)(5660300002)(8676002)(186003)(6506007)(26005)(53546011)(31686004)(15650500001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVNvcUlJaGRvM0E3UHdwc3dvdlVqbVF0Q0pwaUlWR2MyVnk4NTU2WU1yd29m?=
 =?utf-8?B?MFlrdVdITUFyQytHcUpiQlpQMTd1ZHNiUGZQc2o2aGNheGVIbmN4Z1FndHVJ?=
 =?utf-8?B?bHk5RU9YZjkxSjBlTzY5WVlKa2M2b1FkZGRiT3J2Q1lKVlpQOUxqVGxOc25l?=
 =?utf-8?B?elUwMllFRFlyUEh3MDMyWkRLZDZHajQxY3Bid3ZpbmRybXdOWDRkUkMzRkdj?=
 =?utf-8?B?QmgxVEVxZ3N5cHI3SzluQ0JrdVBFb2lpZDFjRSsyUEFjdmxKSDlqSE9qalJ6?=
 =?utf-8?B?MkZEbG9DOFVVREVCcitDVXB5bFpsSHZ5b3R5MC9RSG1VVURZTWQxcUtManYz?=
 =?utf-8?B?MHFLTHJpYllTejNJTUIrenB4Sy90WnQ0YndqOVhjSjVTakdLdFE4T3g1ckRx?=
 =?utf-8?B?MUYrK1k2aFN4b0paVjB1cUVqakZLczR2YUozc1NmcjJFaVhRRUxHMlppd1pk?=
 =?utf-8?B?K2RsYVd0VG93cFVTQ1BvQjVmQTU3ZVZ5M3JTSG02TG5WL2Y2ZStvM2tDblZL?=
 =?utf-8?B?RDZqNytEd1krdWdHdGdvNVU2VDNiTWxQUGdPVG51ckR2TUxBWjdZbmt1Yzln?=
 =?utf-8?B?NHIyWS9DZTVUNHJYL2xoQlRuRUdMS2lTYUV2QnZxYStQdlc2TGRiVGlMOWRH?=
 =?utf-8?B?eUx1M0x5UmlNbXl3eUZSSTR2WVB5WjVrbmVWRUlDOEJkNmlVaG5oc0hvMDV1?=
 =?utf-8?B?YVQ2a1I5UkFBazd5ZXk3aEpQZXovYnhTeHF0bmQ5clFtcXlLUmRYNElsdnFz?=
 =?utf-8?B?YVNWaWt0cHB1T20rQTZSMHc3OVZGWm9Pa21zaENINWxhbnA3bnFMTVdCZk1p?=
 =?utf-8?B?UW9rZXNvNnByOHlBd0VTcjNCcHRhUVdvZHN5STJpcWtmT1RDOXZpRFErUVY5?=
 =?utf-8?B?YWIzY1QrNjY1SG5oaG1sQkhCZ25ZbDZxWWI2NHIvTnpWWWlTSVk0UkJHVEZu?=
 =?utf-8?B?a0Q5QUxiU1QxSGRBdExVcVN0N2hQY3c1b1JWeDVUQ0R0VFc0VGZpN1EzYjIr?=
 =?utf-8?B?TmNPa2t1RnNCYWVURnFBbnBzWml2TENrcElwMEhIL0F3Kzh6TkMwd2NzL1V0?=
 =?utf-8?B?c0hkdTB4Lyt6TGoyVVhtenVuYlFMRjBpYUMvMC9YUGhGSEJTNWl2b2VjdjVV?=
 =?utf-8?B?Y1BMTzVkUDlxQ2dTaytuK2JDVitDQ0pYMXFEQjAxZXU0OWY0RVVNUjF5OS9Z?=
 =?utf-8?B?NEFIN0F3ei9rS0VSeUViV2RpUzdsYmU3MDYvSzRKa2dtZENDaTJpTytjdVBH?=
 =?utf-8?B?a1RvQUJMUzNJall6bjJPT3VuSVovQWRieDNtbEtqTWIyaXBzdEo4S2E2VUFi?=
 =?utf-8?B?cUJXN3l1amEvZGZWTTRHQnYvam11YzB2THlpOGpVNkEzRGRld2NFTVVOQytP?=
 =?utf-8?B?ZWl5LzdDU2ErQVZJUURaQnRBanRLM3lwdUhoRWg1UitSVzlwQW5EZGRRZTBw?=
 =?utf-8?B?SmF0Q1ZwWm82bW12eGo1Y3FSRXB5Q2VXTHdIU2dCRm5EQmozMGxlTHBtMW84?=
 =?utf-8?B?aUdxS2lsNEYvZ2JvcjUrekxGSmkvMWNuNVBYSTVCeFE4aUdDNStTZXhGVDln?=
 =?utf-8?B?VlBXamM5WnU5NHpzVUp1dWFJUFZtWGZMeVlDMUw1TmwxMGM5azZFK0t4WE1h?=
 =?utf-8?B?cFR2WUtocGk5WGgyQnd3aW9hR3NHMUYyMExkYzN6dlFwMWdOS0ZQTG9wU0N5?=
 =?utf-8?B?andrcjBzR1d1Z1pwdEJNL201QnI1Sy9MQmpKWUFuVkhBV2daQStaZllFb01T?=
 =?utf-8?B?MGNpQUo0bnZBS20rUWxXY2VIdUxBK3V5WHkxTFhneVFLVndqeWxPOElEcEdZ?=
 =?utf-8?B?VEgxMDEvWjJhOXB4VlJlOE5HTkFsZ2dXQSthMjNIbzhtVkplUXh5N2pnczJI?=
 =?utf-8?B?Z1dLb3pKMXBRNHVScFV0OWN5S3c0aGZjczkyaUkxdmh1L0ZMQ3hVLzFDMHpY?=
 =?utf-8?B?bHZCZXFUWEJSV25lS21LYnpUZjZTbHhiUXBoMEJyNlpIdGpFTUZVRlEwT1R4?=
 =?utf-8?B?MTRaemE4SDUxWE1JeE90SXlRNnBQYzA0OEpTdUduVE1QdS9uQkdMeXJ4aTU2?=
 =?utf-8?B?YjFzNXZ6M24vTVVBRWZja0E5STBPczl2M0lxZEU4cWcwTFhldXNiVDZzdml6?=
 =?utf-8?Q?jf+LiYL330ZXom32u8fpgjwsv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1fa903-0ba3-4ef3-3623-08db7efb8560
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:04:54.6801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2RmosquIM1u5mIR8YBMLNvuabXoR+GBN1DqW5ZUYl3AW9Sd4r9Gd9WOAzYJi0OrwKwzjicP7JrBuozZ0SBTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
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
Cc: srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

response inline   [Saleem].

Regards,

Saleem

On 07/07/23 12:35, Christian König wrote:
>
>
> Am 06.07.23 um 16:47 schrieb Saleemkhan Jamadar:
>> add session context buffer to decoder ring test.
>>
>> v4 - data type, explain change of ib size change (Christian)
>> v3 - indent and  v2 changes correction. (Christian)
>> v2 - put the buffer at the end of the IB (Christian)
>>
>> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
>> Acked-by: Leo Liu <leo.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 11 +++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 ++++-
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> index 2d94f1b63bd6..9bdfe665f603 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>> @@ -573,7 +573,8 @@ static int amdgpu_vcn_dec_get_create_msg(struct 
>> amdgpu_ring *ring, uint32_t hand
>>       int r, i;
>>         memset(ib, 0, sizeof(*ib));
>> -    r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
>> +    /* 34 pages : 128KiB  session context buffer size and 8KiB ib 
>> msg */
>> +    r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>>               AMDGPU_IB_POOL_DIRECT,
>>               ib);
>>       if (r)
>> @@ -608,7 +609,8 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct 
>> amdgpu_ring *ring, uint32_t han
>>       int r, i;
>>         memset(ib, 0, sizeof(*ib));
>> -    r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
>> +    /* 34 pages : 128KB  session context buffer size and 8KB ib msg */
>> +    r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>>               AMDGPU_IB_POOL_DIRECT,
>>               ib);
>
> One more question here: Does the create and destroy message need to 
> point to the same session context buffer or is it ok that we use a 
> separate dummy for both?
> [Saleem] Both case works Ok. Version 1 change  had same used for both 
> cmds.

> Either way we should probably clear the context buffer with zeros.
> [Saleem] Noted, will make change.
> Apart from that this now looks good to me,
> Christian.
>
>>       if (r)
>> @@ -700,6 +702,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>> amdgpu_ring *ring,
>>       struct amdgpu_job *job;
>>       struct amdgpu_ib *ib;
>>       uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
>> +    uint64_t session_ctx_buf_gaddr = 
>> AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
>>       bool sq = amdgpu_vcn_using_unified_queue(ring);
>>       uint32_t *ib_checksum;
>>       uint32_t ib_pack_in_dw;
>> @@ -730,6 +733,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct 
>> amdgpu_ring *ring,
>>       ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>>       memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>>   +    decode_buffer->valid_buf_flag |=
>> + cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
>> +    decode_buffer->session_context_buffer_address_hi = 
>> upper_32_bits(session_ctx_buf_gaddr);
>> +    decode_buffer->session_context_buffer_address_lo = 
>> lower_32_bits(session_ctx_buf_gaddr);
>>       decode_buffer->valid_buf_flag |= 
>> cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>>       decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>>       decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> index f1397ef66fd7..2df43cd76c10 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>> @@ -166,6 +166,7 @@
>>     #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER    0x00000001
>>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER        0x00000001
>> +#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER 0x00100000
>>     #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
>>   #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
>> @@ -357,7 +358,9 @@ struct amdgpu_vcn_decode_buffer {
>>       uint32_t valid_buf_flag;
>>       uint32_t msg_buffer_address_hi;
>>       uint32_t msg_buffer_address_lo;
>> -    uint32_t pad[30];
>> +    uint32_t session_context_buffer_address_hi;
>> +    uint32_t session_context_buffer_address_lo;
>> +    uint32_t pad[28];
>>   };
>>     #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80
>
