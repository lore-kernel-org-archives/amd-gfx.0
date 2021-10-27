Return-Path: <SRS0=hGuQ=PP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE19C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C08260F9D
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Oct 2021 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C08260F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF96A6E8A2;
	Wed, 27 Oct 2021 14:24:34 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC8E6E8A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Oct 2021 14:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2pDoE+M74tbqLREscGK28QjT0uUZnaodX42Sg33k7y+q6jJeT68hWvpEkpkXyVbHwmTr8jfTJ0fmuEt8IMxZyqDWvLOirSZVyJCF5zhfB/a8UaeZvZI2p1pWE5yWncORfPCxOUcWtGZInRrJmtKm4jiyV11WjNQvW4tYig/q4lQeDf1Wh++1xxIShYdOsTkcyFra9AGFXLHxFT2fJPCJuaf8KkeTNbMT0bJ/DjRezoMmEt4Vt4BMnnZtuXJCLL67TR5e6TJwSPsePwv/7tHa0FDNNewrL4T6q1dYvDlFgz4Ve5atZKjn0TfSRIegGZ+OhbM8ziKIeespObD2BaBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR2iTmcMgKidV1tir0EyjxxsvJ3nrf6BLhlf3RJBxKQ=;
 b=SkPLH/45Cwc/THW/nbZ92T0NicUaXPhhC5mgFL1+/Q5KyF36lNxPOk77rd86uSPfbL2jPB47Fk/4bX6BOCP264DAvNMZp924oI9rF9X/RSfhCa5xP3Xc6k4VhaRkk7NNO/g62q/39T7FEqjK9FnMnc7Usgr/f6cgaW/Imu/dq13Rjzfebat9Y4TrfwP30Pw4OYzJr1xp8suWDIhLt4KinapT/PqzUhKYzE9XmjtoFtlonQ4cdTJ8nCSs3wucZWcMDNVsqF81GZuUWW0ajUKse72wnjOZybQD+qwFlAaB96DnvvNGSPkZil4SCvjWYDVVxP2Ge7vA5iHMQIPELQQgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR2iTmcMgKidV1tir0EyjxxsvJ3nrf6BLhlf3RJBxKQ=;
 b=SlUdfEjGk3FZbVUMEySFDoLHS74DuxkmLKCcSascxaz+GSGxU1th0iuX3p6jgXMqC2xTVs06CaXYnoz+/n8U/kNGYvIQ92TOt+XaOCWqsAFURybl8MxwxFXr6xfTgIM51Az6lSULxDIT1aTFiToW+0d2wpk/uXMqGNROc2hiwPc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 14:24:27 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4649.014; Wed, 27 Oct 2021
 14:24:26 +0000
Message-ID: <89947fca-468c-232c-fe73-dddab2fbfdf7@amd.com>
Date: Wed, 27 Oct 2021 10:24:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: Fix even more out of bound writes from debugfs
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: tdwilliamsiv@gmail.com, alexdeucher@gmail.com,
 Patrik Jakobsson <pjakobsson@suse.de>
References: <20211027130312.28383-1-patrik.r.jakobsson@gmail.com>
 <c0744024-bd4c-3849-d218-053377c28b44@amd.com>
In-Reply-To: <c0744024-bd4c-3849-d218-053377c28b44@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Wed, 27 Oct 2021 14:24:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db012c3e-7c44-4a25-73e7-08d999557b16
X-MS-TrafficTypeDiagnostic: CO6PR12MB5442:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5442264CA60C953AAFBE66DF8C859@CO6PR12MB5442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYHaNMowqwBjI62ciJhYFuBlMfdcaPLszXKp7GFlHlX7elXCHs+70iV/kR7Dt71oizfMf1/9xopynHYZdWJG3P0TUhxJbwY1yw9DO9O9aMjMAjncp0mjP3xOip9jLpkM0Yd4m8Ti9KXaxbcYAz2kvaC5NneJHvmGdiJq6HwQk+2m8+BOQAyGHscwKZ0TUXU+mRYLk3NGneQ2kQatTwECMy05CHxVurZrwAkkxKLC1TMyziJiIZhCF9sPeMlEiZ/e2SxlpRdQ7T+cyAgmGf0mZ81ZlgQruxZ+EsozMISc+tB2+FG6WklegP31K3O4CaL0Zj23eAmbWUMXNSG978inmKY9kiXPBZA2+rMrAzmVR4+R9s+7w/au/DCTYNIB/DfvAE5NXd64gbhmV7bMC3A4zm6WESB4JUKIjTL8RN5H/fx8O+yS3ajemyg/7mCaf0XG94Bipu5/bL6/Hxq1NrvF6568XhPsxrEAUUrVsJqsFoMsyivK/L2xcOFNHBX9CwQf8b29sEGqu16Mew4JZGfXgAqS98+wRI9aRD7xqBJsOxHiKPUusfGWxNfWj2LfeLFumizzNomp4nX3k9qcWDPX+NUG5V71SnfHcMvBVR6AwXJOLi4skdk5Cnf2n4aiOy7QJze/eRT/4Ru1cg7F8ww+wNLNK8vJqDzXYPh0hG9HcV60fuurqL20CXXg8Ei/eFCk8h/gpsnJYuiWrONsr1aurVQGGdHc/XdPs8WXPG6DIW7k2h7TxYGX3twaH6+Phqq7LLgJcs/wIN2tWegnZYgpVGli8tthiCrt53LtsdeJn6ip7NQeTodIgZ5jW/6MDHnbuPrh3j3+IxhsqjNwPM7zLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(6486002)(31696002)(4001150100001)(2906002)(966005)(5660300002)(508600001)(316002)(16576012)(31686004)(36756003)(38100700002)(8676002)(2616005)(53546011)(8936002)(186003)(44832011)(956004)(66476007)(86362001)(26005)(66556008)(83380400001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEt5Nng0NFRBZWV3UFJycnJBTHlEVkllb2dlUHk3TUp4RHhNY002NkI3SGdJ?=
 =?utf-8?B?eFFJbnhoeUViY2o2TmdwRmMzMW11cUxUcWFMdGdSdUJmNzRCV21NL0EzZjdZ?=
 =?utf-8?B?dnVid2s3dFM5dEJpbU1ZdDBRc3MzRjl3aXhhSStlcHk1WjdhSitRZ1djWlNr?=
 =?utf-8?B?WjlwcGRRN0k2alZCTVJTM0FRYmRZM2dveGIzbDJmU2JjVXV2OGVRQW9XRWo3?=
 =?utf-8?B?RGxCVlBuNjUwd1JnM2F0YnI5azJaTDV1emthZUZLVkI5eitLdER1M3BrMzJD?=
 =?utf-8?B?U3A5QnFxQVFmaHA0djZhckRweDB6WUFyYkFMYTJEMjVrZHhrNnRxOWhzcmhN?=
 =?utf-8?B?MnpndzcwcmVoR0ZzOUZPVENxVW1qZ09aZGlYbUY5OFRTUzhsU1ExYUxHY1U5?=
 =?utf-8?B?OXVNWUFUNzVkc3lRWHJydlUrQVlCUGJXZVBvYXFDUXF6c0w5SmVmV0d4MElW?=
 =?utf-8?B?RUdtWk1ydEE5NldYOUFNZnJWVmtPcEF6NXJvOExucDgvRG9Pd1h4VUE2QUNh?=
 =?utf-8?B?aGxPOXpzbWZpZGdkTlByY1c1NEtlL0lKTFJuYU9SbXRnandJMFF0cU0xV2tR?=
 =?utf-8?B?SVdpVlc2K1JWS3ozQmlMVUtqd3l1blNHeHhWOEw5UGdLMlBTU3ZqeDNlN1E3?=
 =?utf-8?B?WmdubG5QUXV1QWFaOFhSb0FCS21PaGVoQ1p5QXNucnRBT2FqOTRBcFlwdkdX?=
 =?utf-8?B?Q2tFU3E1THBHWU5SWDRyZXNROXdtalJDNFhnUkFIdTZtQncyZDdwVk5ra1Ba?=
 =?utf-8?B?SWNlRlpKMi9lSmlZUk9VNXduU2RVVkZYRGVZeTUxdGJEM2FDZ0JkUXVmWDFP?=
 =?utf-8?B?dmFWSjBleThWcmlmeWFQajFLa2xZaFhjYTMyeDZTOGFkU3BFVmp1cGp1dUt1?=
 =?utf-8?B?UEcyZDlDbWZMSWs5MUJJVldkVWt3ZU04VGpqeWFETXYyN0lGYkxMaDF5VElM?=
 =?utf-8?B?bVhDdFZlQXVaSHhIUFkyanYvZkhVa3dPTkJRdlJHOE5SOUIrM0pJWGpOdEM1?=
 =?utf-8?B?MlV5THlkTW9EUmNDbUlOTUF3Ulp1elgwNHpmbFMyNzBRSmlMNnE0eWhVVEZS?=
 =?utf-8?B?YXpIdmJyVlNiRzFnZ0o4SnBVeTBqTHdDRFgvR3dnU253dER3MVg1c1FYaHJy?=
 =?utf-8?B?ZXBqTCtWanJEM3V3cDI3cS9DMFMzdHVpUWJtZU9qSXZCRHphOVgxeHQ0SkY0?=
 =?utf-8?B?SFlIa0lRYXRUQkVXdlArbXJSYjE2Ty81QUVJZTFOc24vS0NwUHRlNk1WWnVk?=
 =?utf-8?B?eWhqM0lQWmNLaGhkNUN0VXZubkhpN3Y2dUs3ZWpmc0RuMEJJRWJxTE41ZVNv?=
 =?utf-8?B?Q2QwSzRYY1k5VGl5dHQrUW1ueWwyT2hJWnRRWW52QXdnYmZCMkYvMFQwTDVQ?=
 =?utf-8?B?ZXQxWUxkS1dQNmlHTXh0NXhldnRhVlpSV3ZQcVRmVDk2Y3M2ZmdPZHpjRWdy?=
 =?utf-8?B?QzF0UHU5QnFpNDFtcXR2NGJiMFo4N1FicFFicFpMcnlEWGd4TTBUOTBZb1Jl?=
 =?utf-8?B?SGFkSFJkN0NYWjArT3hSNFA5S05TcDFxYjFjNkpMMGdTY0p6VUk3QkFDQ1Bk?=
 =?utf-8?B?ejMvZnAyVFE3OGVpSDdsUjMzRHJzNG5RK2lHQkpkejZINkJHRmRuTGM2U0xB?=
 =?utf-8?B?dzNIdEZtdk1KOGxWOS9CZFQxM3N4RjRvWTlDaDdFaGM0Y3pra2RUbTZvZFVN?=
 =?utf-8?B?MzlPNmY3VUpxditVUjRFdFJKRXNzdlM4dG1uZ0UzQW80eXVJQkhVd3gzYkl1?=
 =?utf-8?B?QVd2WXRHaXZVclg0aXUzb1hqUThQODJRR1dCY3RHbE81TjBxNG9vOWFKSWEr?=
 =?utf-8?B?QUNPZHhHdWRnczl3QVZCVS82TmhsNitiUDByRWw0bzZqdUx4Y3JWSHVKVnFF?=
 =?utf-8?B?TWNoVjlkclBVTXhBNGo3ZGl0NFltenBOaTN6Uy9FNE5FTXNLQVBESU5wV1lv?=
 =?utf-8?B?ajBvMXVPdEIreWY0QnJVTWFSQnBUVzNDQ1BQTTVVTE1tYjJLemExZ3poQ3Y0?=
 =?utf-8?B?WjJqc3FUK2VFeWpSRTdJVThkNGNUVStrcFh0QmFiSWZ2QXRGVW1OdnhCTmNn?=
 =?utf-8?B?Z1UwQ1YyRWxCU0hsancwL2FQdmhaVlNvN0FNMHl6bVhlV3RaYzk4N0hrQkwx?=
 =?utf-8?B?Vm5OOGV2dzUvV1grV2N3bVI1aUkvVko2eTQ3c0xHMVQxSXlaMmRra09vdEda?=
 =?utf-8?Q?u9JXkyPlyh3qVYO9v8EXM3c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db012c3e-7c44-4a25-73e7-08d999557b16
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 14:24:26.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA4QwWwygVIXned4s6kQMwDgzdnqiQfNf1s5xjS+Xknp6l5oGMunDUMsk4tOyfSrIzl/9QGq2wB6GamTcegD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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



On 2021-10-27 09:47, Harry Wentland wrote:
> 
> 
> On 2021-10-27 09:03, Patrik Jakobsson wrote:
>> CVE-2021-42327 was fixed by:
>>
>> commit f23750b5b3d98653b31d4469592935ef6364ad67
>> Author: Thelford Williams <tdwilliamsiv@gmail.com>
>> Date:   Wed Oct 13 16:04:13 2021 -0400
>>
>>     drm/amdgpu: fix out of bounds write
>>
>> but amdgpu_dm_debugfs.c contains more of the same issue so fix the
>> remaining ones.
>>
>> Fixes: 918698d5c2b5 ("drm/amd/display: Return the number of bytes parsed than allocated")
>> Signed-off-by: Patrik Jakobsson <pjakobsson@suse.de>
>> ---
>>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c    | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> index 1a68a674913c..33bdf15febc6 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> @@ -491,7 +491,7 @@ static ssize_t dp_phy_settings_write(struct file *f, const char __user *buf,
>>  	if (!wr_buf)
>>  		return -ENOSPC;
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					   (long *)param, buf,
>>  					   max_param_num,
>>  					   &param_nums)) {
>> @@ -643,7 +643,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
>>  	if (!wr_buf)
>>  		return -ENOSPC;
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					   (long *)param, buf,
>>  					   max_param_num,
>>  					   &param_nums)) {
>> @@ -918,7 +918,7 @@ static ssize_t dp_dsc_passthrough_set(struct file *f, const char __user *buf,
>>  		return -ENOSPC;
>>  	}
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					   &param, buf,
>>  					   max_param_num,
>>  					   &param_nums)) {
>> @@ -1215,7 +1215,7 @@ static ssize_t trigger_hotplug(struct file *f, const char __user *buf,
>>  		return -ENOSPC;
>>  	}
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  						(long *)param, buf,
>>  						max_param_num,
>>  						&param_nums)) {
>> @@ -1400,7 +1400,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f, const char __user *buf,
>>  		return -ENOSPC;
>>  	}
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					    (long *)param, buf,
>>  					    max_param_num,
>>  					    &param_nums)) {
>> @@ -1585,7 +1585,7 @@ static ssize_t dp_dsc_slice_width_write(struct file *f, const char __user *buf,
>>  		return -ENOSPC;
>>  	}
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					    (long *)param, buf,
>>  					    max_param_num,
>>  					    &param_nums)) {
>> @@ -1770,7 +1770,7 @@ static ssize_t dp_dsc_slice_height_write(struct file *f, const char __user *buf,
>>  		return -ENOSPC;
>>  	}
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					    (long *)param, buf,
>>  					    max_param_num,
>>  					    &param_nums)) {
>> @@ -1948,7 +1948,7 @@ static ssize_t dp_dsc_bits_per_pixel_write(struct file *f, const char __user *bu
>>  		return -ENOSPC;
>>  	}
>>  
>> -	if (parse_write_buffer_into_params(wr_buf, size,
>> +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>>  					    (long *)param, buf,
>>  					    max_param_num,
>>  					    &param_nums)) {
>>
> 
> 
> Thanks. This looks good but you seem to be missing another
> instance of this in dp_max_bpc_write.
> 

This patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

I'll send a follow-up for dp_max_bpc_write.

Harry

> We'll also want to Linus's suggestion in [1] but I can post
> another patch for that.
> 
> https://lkml.org/lkml/2021/10/26/993>> 
> Harry
> 

