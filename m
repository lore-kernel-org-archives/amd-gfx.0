Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70192C43217
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2023061A84
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 17:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2023061A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95346ECE4;
	Thu, 21 Oct 2021 17:19:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C676ECE4
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 17:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS3ChbSq92Q0yaGMM4ljxMLFCviUGw9CGwfBzKtW+m2lweztZkKR/gXv/iXTOHyEH3aybuimPOWnjzugR9m1cczWWKGVFHKE6r6d1gPhw1GVJCKO5ZlMC4axm4dsLeS8vENHbDOIiH+WEXDIJD8CZFXI+F2xWdrEPXmnfBkU56804CjQgdXErpJD4qrO3sENT3piXadwFT2coKOIFrzSALjUzyENZKyXTH+0UuIj21zW6U49KBHJ3Wd2E2S4janzigdhkzznzMsHLgndPgsEadKuzRy48jGk2GQbo/BZUdZ+/F55wonn4C/jFc2EDhdElQ1oyWj9cMDOXvGfLkjHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrLn5Tyk2QZHfAH1sy4G103fKP5LWD62EbML7KvBQjE=;
 b=JkZgUTsF477ZjNXRNhaRKu9lgObkJjSLBSECS4iAr7a/kMgcRILXGMPoAEAdLiTd1MGru2FwQC2eLZxudBKEfNouShl7sUjmVisc4M5bDicyftlQpjQdlB2wV+bsgitL0X73Jq65+ubbOSsBjuE+9twgRFeM8GyERxnDlYV47i7XFQqCWS/hpuKDpe0ItJte583eQBngj5Olq9etgnIEASeUjlK4Ei9DqIl5GYGOUPg9UV0l+ddLIjYStfniZ9IqOrRqY0Uekuqac+X+64VRC/EFbIU21Ow9JK0UGKLe2XcvWLVu6GzqTmZmnG6e6ocSpfWLWSB1+VsHVd0jeAEguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrLn5Tyk2QZHfAH1sy4G103fKP5LWD62EbML7KvBQjE=;
 b=qgOr5QvXWUbB46nmCxEI6Wg6mOHXWEC0UaZHQwch4zYNlGoMRBk85HuHfzcGlKDeAtSBKybbGd7gu09r7I6imrCtS9P5Qy/WavkgbOPOYxUfIKNCTgCJza6BGzMv0CTn2p28VxeXnE4tF1VW0T1x6WOzQN6CvuwzM26ek3WymX0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 17:19:01 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Thu, 21 Oct 2021
 17:19:01 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
To: Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <9a224b0f-1538-2307-8c44-6b41498cdf75@amd.com>
Date: Thu, 21 Oct 2021 13:18:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 17:19:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8422b5e-cd58-45d8-2259-08d994b6e024
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35152C371E9AADBD38F7178392BF9@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYOPhSW+O0wPd8wJSLsbquQKwOre8cnA9YA9X2R/CVlvI1nblsENpMzRtOL1YEs3SVfhcTjz9mj/JdhRwrhJHsgGHxvoUlSd6vcaQ7kq6JALnUYDPAvbhwCngsKXeeuzk2CVbYRM+6LU/f+FQdlVa0ZjWyYj18Xxw8bKpe2dq3j/NqFm5HnokaUB82X3+h5VWl+ywFNAHDzRILZVGIV6y+1MlYkGEFVq0/10Zn34XLWeJinK0FzCSa/9dBVdCEJ0qlEHPzaXch7f/UTO7jcAgcYQiDY1VUH4OjZ72CbDLehCQNRkNM4jXwC44Ln2ezzOO2Ig99NYZLNkKnUEBM3PHpbVYCymhnFtAKnTqn3hL9MPX3SDbwdJaRVkb8zpH1VZEslj/M8rbvfNLMpQVRVpX+/YQ+G78jLsbBjkyFq1PNmL3DEvRQ22M8plSkjxmiJr3KBpa8HOg10SiAx99MfIjJ4qCnfSMTy4IaL3sLsVWo+R2PN/sgflc8f0Cn1IgkS1QL4FkJP20zfm/CUgL77HYHT6L1ZC5xrd22cQwUXb/VEksz6i+00cr9S8+fq9/8LD0MHZ5N82xHGvACSWuRF1UmxFzW+R/ifbFZKFucKhOlansZE3veouwhPZvVzGRHRKbzWhI7mhTGzWqZJcSZyL8LCCGMz22xOGFnLY+4aBOTEl3VyDkHvry5aGndAJfx7xQmGZipRacGomfOVijlTbQTjhSjP4lkq3L3j9hVbN8hj9OXgC0FfxypUXD7HocPmk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(2906002)(110136005)(36756003)(31696002)(16576012)(6486002)(66556008)(31686004)(4001150100001)(38100700002)(26005)(44832011)(316002)(53546011)(8676002)(956004)(186003)(8936002)(83380400001)(508600001)(2616005)(66946007)(4326008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWtvc0tqcjlpeGJVc0kwMDc5SDQyZk5vY0VWTVV6ZGl4VE9zK3hsSlFQclh2?=
 =?utf-8?B?U011RkFGTEhNT05pVkc4MFQrYlBVaVFTU3pmM2FjL2ozZVI1YjRxcGliUmNI?=
 =?utf-8?B?dGRMMHNoQzhVRzE0ZXp3RWprTmFVc1daYTZXK0NpOUgzZUtjWUJGSStSYXdG?=
 =?utf-8?B?TWxQb3d6ZEZHOXJZU2s4MEdzYlBwemNlKzIyRjZiSEVZSnFYdEhFL1RjSHNp?=
 =?utf-8?B?MGp3STk3dmtTYy8vM2FHenlHS0d5akNsSnlpeWgrdXM5eE9rRVp4YnlTRmEy?=
 =?utf-8?B?QlUxbCtzQWpPTENXZTdNUXppL0F5MVZUNHhKZUZnZHcybUpiVEI5L2wxQTJy?=
 =?utf-8?B?WDJGZmJVOHBMaFJUR1E4dkFqUEpsUFRuaytWVUFtMDdBZ1NNMUUza0c0MWZG?=
 =?utf-8?B?eG9rMTR3ZHZ2VzBYRGFCWjkzVGhLYjVaRTZJajZMWXdBN3BIdWFwZVZERlRI?=
 =?utf-8?B?elpFdk13RUhaZThROXNMTVl3RkFnMVdxenBsZGZybHlGb3M4S3hPQ0VEc3RR?=
 =?utf-8?B?VEtkRjh1dm9JM1VYM3ljaDBBUFQ2YkppbHgxMDlaYyt1cUQ4NFdndUxPRzUr?=
 =?utf-8?B?bkkwTWxuUGlxWjJmcXNKQ2l0dzYzRWtmWjRON0F1ZjYyOVMyUzJ6aWhSMFQ3?=
 =?utf-8?B?aFNsZjg0WXcxTUIvSjdBQXM5NU4zb1ZyMFd2Sm1TNUF4UjRMbEwrQTdETDlI?=
 =?utf-8?B?VlpHT3ZDTHRHZUs5Z2lxUkdBQmJtb3plRjZnUWpwbnZoa3E5U2d1WlNmUTQ3?=
 =?utf-8?B?RE9YdCttZU1vU1gxNVo4TlBJL0RzbGhvcVBDbWQydnZUV1hwUUQxaW1JeFZQ?=
 =?utf-8?B?UFIvUkpFcHZGQmtIUGg1cjdZZFB2M3A5bHdmMFBuaGhaTVhqMzhPVjZDYkxa?=
 =?utf-8?B?U1RIdEhydVo0N1BOWE56MzhLWk5FQmovSmpVZkhnN2VvSGpadzRvQnJSTC8r?=
 =?utf-8?B?SjBpNkQ5UWtSc08wREJ2OHV5K09lK053VmRPSEs4S3ZjREpxeXpBOU1JcHZy?=
 =?utf-8?B?WTNSMnFjOG1zdzBnUkxTOXprUE9WMHFBK25xYjdIMnF0OVBVazVNMDRQT0pn?=
 =?utf-8?B?d2NVTEYyVzRwVlJvZTVpTHRsM3Q3T1pkM1VEbHN2Rit2bEh0Y3gycnFrR0d1?=
 =?utf-8?B?T1lpaWI2LzVGaUhJS24zbTljaU1IZVBZQ2d1NjVDZ0dmWlc3dzlFUlIydC9F?=
 =?utf-8?B?RlVIQk5ZN3pOSFpXekhVZU1hWmhQR2FQRktTWllPaitWV25XVVlUSEU0K3Ur?=
 =?utf-8?B?QWQ5a2sydmx2eDF2SnIyRmpxUFJoWHI2RktVZVpHTldDTlNndHZINU1vSWQz?=
 =?utf-8?B?dDAzUm9LN3N2YVNKWWFxalhjYU1Jd2l1bVRHNjVRVFA0a0g1ZVZtR2YwQ3hC?=
 =?utf-8?B?T2VwSTluemlCZlFCUHhSQ0Qxek56SER5VE5ubDU4T3hTTnUrb2F6elFDbDI3?=
 =?utf-8?B?UjBYS3graXNLYVFPaWh2OHpjR2J4YXh6Q1liR3ZRYVc2WHRYUzA2VFRvbzBD?=
 =?utf-8?B?VWxBMUpEOGNiREk2d0pqenNPay9makkvakNBQ1ZBYllLSmFkZkZITWlVSFZU?=
 =?utf-8?B?c1hjeFNObm5Hazc2c2xCOGNZTVhtN3RoZTF1emxxd2hSd2hYVEhJQm5GWU1F?=
 =?utf-8?B?amZBV0ltN3FENm9tWFFpVGxsTkkvU1FlTWtSM1V6L2VvaXBOYVhuazhTOGR4?=
 =?utf-8?B?eWlxUkJvMnM2cUFLVC8zVjQ1NGV3MlhRZ29IUkJZM0ljaDJwbmh0eWJTYmZn?=
 =?utf-8?B?RTR3dGliL0JCa1E3K1UyWHBZM3h2cGFPdjAyOXgzS0JKWFBkOE9sVTFNNExQ?=
 =?utf-8?B?TDZUUVltLy9SSGl3L1Zydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8422b5e-cd58-45d8-2259-08d994b6e024
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 17:19:01.6558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkuehlin@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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

Am 2021-10-21 um 12:35 p.m. schrieb Luben Tuikov:
> On 2021-10-21 11:57, Kent Russell wrote:
>> dmesg doesn't warn when the number of bad pages approaches the
>> threshold for page retirement. WARN when the number of bad pages
>> is at 90% or greater for easier checks and planning, instead of waiting
>> until the GPU is full of bad pages.
>>
>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index f4c05ff4b26c..ce5089216474 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>>  		if (res)
>>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>>  				  res);
>> +
>> +		/* Warn if we are at 90% of the threshold or above */
> The kernel uses a couple of styles, this is one of them:
>
> /* Warn ...
>  */

That's a waste of space. That means there can be no single-line comments?

checkpatch.pl complains about multi-line comments that don't have the
final */ on their own line. But a single line comment is OK. Let's stick
with the coding style recommended by checkpatch.pl. If we make up our
own arbitrary rules for different reviewers and different parts of the
code, I think it becomes a mine-field of pointless cosmetic fixes for
anyone trespassing on unfamiliar code.


> if (...)
>
> Please use this style as it is used extensively in the amdgpu_ras_eeprom.c file.
>
>> +		if ((10 * control->ras_num_recs) >= (ras->bad_page_cnt_threshold * 9))
> You don't need the extra parenthesis around multiplication--it has higher precedence than relational operators--drop the extra parenthesis.

I agree. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards,
> Luben
>
>> +			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
>> +					control->ras_num_recs,
>> +					ras->bad_page_cnt_threshold);
>>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>>  		   amdgpu_bad_page_threshold != 0) {
>>  		res = __verify_ras_table_checksum(control);
