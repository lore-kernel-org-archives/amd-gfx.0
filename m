Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA5DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2E694FD5;
	Tue, 12 Jul 2022 15:27:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8205694FD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQfsRZi3P7pmesTawDPvCxRnc261blT4BsZQ/V8cLbMbXKqLibI7rzWwSlhq2oSCQM0Z1KH2/cHsP2S1WI8K7bSash0peCw3mYekVW5893ax6Wwz9QIFMrekhhUoHDJG87w3iFg9f5wpd1OKOSRhGT+AAVOfmnJtrp8S96X40hihl87aRIE0Xs+mYWi1kTEM/9v7+EdKUVKv6sAfjJg5uXeCdTCrLG2WdDMXpw8LLnJ+HVfz9A7a0KU6zeHq0ER2YQ2D0unz1c848EEHggbu6L0HGE2l11Pha69Pw6Qh1tmwP0ue3/zJPpNvQFXS/o//CUgKApn0YHCuGrDbEDWKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMJvCDRc6SaA6F34rXKlchHLaEYybVpMaYdBaQ58cXI=;
 b=GxKQXjmJXZAn51lnU0AqtocbIbU5lfQ6YFQIjkNcqRjxJLvxaki0S11mIe5Iokcsed0NmDHZmmQVymCE1zok83Vwz5BFu6N0QJn7Xkv0wUaEt9ssmgOCvfjiCqEG2/+T6aiBZ5K97/OnCRUUL5YIPp6CSlpK0DzCUbguBiTy6UPakWqED2ZAkozQov6vF/CSGCt7YGH8zNIJM6qYzoqwF6eb8tnueQFz5XaMaMFpWEhHLP0XCc2W1CjJyr0LhajszI1ou1W+URB9S4i6YtX8TSkSC09qM2EL1ZwjjgqXldFgY3KIwzu9ylx82TbsNpRvRzcdgH7R2JHfrt5ys2TY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMJvCDRc6SaA6F34rXKlchHLaEYybVpMaYdBaQ58cXI=;
 b=y6/fsACh+rDoROfuyK1vl0Wej9Mf5A3XiKV1eSHHIYnq1l3mTtjbyZoaHqzFVPKU6DraTixbjN58OawDUHtR0l1gZ1PODre8DRnfG41nsNFsiXRMxYOBiqkAwK7E8CFUrt7g4xTilNddlfpfkKJbn+JpiD6mTV5RXkqM343MVFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 15:26:53 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 15:26:53 +0000
Message-ID: <78cf95df-3ca6-3ae1-f69d-2b2d3744c77f@amd.com>
Date: Tue, 12 Jul 2022 11:26:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: make some dc_dmub_srv functions static
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220708155036.1092134-1-alexander.deucher@amd.com>
 <CADnq5_NtVbuAwgEUoNc+KG+y7BNswjpcP-5Yi_9V-h-ODc1p+A@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_NtVbuAwgEUoNc+KG+y7BNswjpcP-5Yi_9V-h-ODc1p+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f60bdf9-f2b6-4025-ab2a-08da641af296
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Az8WV/Ll5Z5NzsT6JoJfWvN9TGvoBi12oGda00zhhifEBfq2uGTbH3s6VssfUNevNfvnNjHE97uynvFOC9RdYLtHpUImK1CsxS7pXmc89/etLFQe4EkQBUpV9arOqNnN2xF+cCoprM9XvqPQFIyWoXZm6xR0iAIrJuVEM4Jmre7EdjcChjJsHfW1/U95/n+cC/tW2E+uTHYZqxpXBpw9nJ7BLUbub7RdadefaDpLVJkuQw1I4uYpaDBbGuWwg4WolsOdMAAUjhTRU7dS36a5VUkrrvwUu/Xg7nh2TCelS5mZgUCtMxwOzOAVNqXApDLfIFl/bT6Ls81igPd0qY9JMYgzzzCJvjGGs6+FWdIe72V46lHlxGS1c0piKou29vggm0rf9dHDEU9F0tMdqAbWBFgur4fdD+IiGK1yd+jRSf8lfd62xPSYnCAGl429Vn+ahy+I2UKPcoBzithKeRYIP2Pr5aAyk95Zqyj5YqIAKLG6YBN3R4X6SJ6fK8l4dg+6/FLqRLHA+0AoM29ibBNkwGrWF/3vU+tVr7I0Ox0YpZz9NYdUED2CesjqDf6WvZ6roR0hPMVTB1HaF9MaOEpdvX6hExlEXxo4HEinILk2c/EE+tMV9pEIxyOZXOwXMfTgVfthuduUl9pMt+UTDEw7DBDrFBPxF74SguPK1Ubdm6RUNOoS+kJMLHrC9Sa7baKwT/MYzvulHliNufYzYZwI3ObHaGMUHOOy3dM6y9Tu7sMu7STlyI8jZ6w7mLMa4zPshnOkoPA/UMKlxujFIF6qciCIMkIuAqypWXGp7NF5v0fSXrcXRpsMH3vfcVjCnYzrhZt23K8h3i3DLz3IEJoo1GyvraEfzfAUFBijOYSROIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(41300700001)(86362001)(54906003)(44832011)(6506007)(110136005)(6636002)(26005)(6512007)(31686004)(36756003)(5660300002)(2906002)(8936002)(6666004)(186003)(38100700002)(66476007)(2616005)(8676002)(66556008)(6486002)(31696002)(478600001)(53546011)(83380400001)(4326008)(66946007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tTbUhaYzFkUmhJczAzcXRaVGpvbE9ISyt4VFhYcXF5eUZCVkJjSnRVa3RY?=
 =?utf-8?B?dWpEV0lvYUtmc2RFNDhoczQxaXJmV1pBTmRpMzVQcUE5emxzMUF6bVQxWEg1?=
 =?utf-8?B?WVp2Q0lhYm8zNEpCRnhKbjEwaUNlVENwUVA1WmpaeWs4dHNsb3llUitwYldr?=
 =?utf-8?B?VWdkZ2o1K3YwcGFtNjNqYTZZTlMvalUzc25PYTFUZFhaVUZPRG5DQ3M2RytC?=
 =?utf-8?B?UndOK1V2LzFaTXJOeVJIZGRBL2RPN0xxcE15ek9YMHVpQzlaTFRCdjY2ZjBm?=
 =?utf-8?B?MGYyYk9IYm9yeUZBRnZ3STJJOWhJdWpUYkxqVUczdEdMOFFFdUdsNXBhdExx?=
 =?utf-8?B?d1ZheHlqS1ZBTWlpVlFxUHJJcktMbVMvMnpBZ0JxMzNCVWZZSTdjOVBYOG43?=
 =?utf-8?B?TzJMVTcwR252a0xJL2pqUXhnT2NHWm54VlhsZS9ObXRsNHF0djlnVjRNNytL?=
 =?utf-8?B?ZTJnOGIzb2t0SW12NzRBNHRXRDB0YW5GSG5BU3ZSVFpMbHFLU1pROFozUHFT?=
 =?utf-8?B?R2lJenkwYWcwM0JGYkpodjk4Y2ZodHRlRXBlYVhaNDhNamprTVhpYzRhTWtH?=
 =?utf-8?B?d2hkTlY1NmViT25uU2lvWFJwdTRVN1hLcnNwdlRxcG1sU05wZmE5Y01FTzhr?=
 =?utf-8?B?MXdGQ3VLRVJlSmdma1RIQVVucHJoaElYSmVRU3NUUCtLdDFzdzR0OWp6MVdv?=
 =?utf-8?B?bWVmMWRWakRJeVBDYWhnK21Za0JWY0xTTkhWNnZMbTY2L2ZHT2pETmFibmtN?=
 =?utf-8?B?a0pvQjdEVDVRbDBOelowOGtRSVQvRDMyTFpzbjZxZE5pZ1dGT05UU1Qrc0hy?=
 =?utf-8?B?ekE1OXVXZi9uL2ZUcWFOUnM2c0p4YlRnT0o1a2JtYU03NGFuSGQ2enliUU1K?=
 =?utf-8?B?OStudE9BaWhpNGFUbU1vUnhzeC90ZkJod0ZFYy9hK201dzNQVmlYODNaVjNS?=
 =?utf-8?B?VUM0TVo0WGN0ZEtSb2pzOUN2bk9NSWpjZmM2YklPcFMvRHNGdy9FVXQxcCt5?=
 =?utf-8?B?aXlYQWJhVUliZlFkUGdGamNud2kvcGpmenlUUkdDUmRDOVJPRkhzczdOTkh0?=
 =?utf-8?B?a3g0bExLdHpFZXlLRllwSzZrcmIzcTN2eG5JQjhHOG92THJGT3JFbEh2b1BM?=
 =?utf-8?B?VDFtZFRtSGNyMnVacXBuTjdZN2Ryck5Ic25YazlKNy81K0cxSndZNGlUYmpq?=
 =?utf-8?B?b2ZKMWRDQUlPdFNQTkQxYk1jMkI3aUU1cTVYOWRMd0w4VGJDUWQzRENTeW0w?=
 =?utf-8?B?d3lrc3lWUjhDQ0ZDZDh2QTZZRzVkaFZXUnVvS1BpbGx0Z2U2a25pbWdNN2pI?=
 =?utf-8?B?OE02T1J1TzE2UWN1Y0lGZVZWUnFWVnpUaGwrU3FIaytjSG16QU1ZbElkUWZN?=
 =?utf-8?B?ZUtid1I2NXRPZGxzZnkrN2diRU5LMTV6ZWxiNGx1c3h1bzNUVlRlUGliWUt3?=
 =?utf-8?B?UGVrTjZMaFZodUdibmpTYS9GL3JSS1pHdFF5R0xUQ3AxaFNCSVkwRTRmMGls?=
 =?utf-8?B?Z3FqcktFTkM5WTN3QVlQZVEzSDE2WHh5VzNmQkRGTzRxNjQwSzhRK0pOVG1z?=
 =?utf-8?B?UVQ1c2MxT1FyZjFUam1YVGVBNDZsN1ZZZGswTUVMQXFSQjhsZnhPdGxTTi85?=
 =?utf-8?B?TTJWYjdDWmhBcnpLQzF2a2cxR0h1Y3hLbjhLWXJNVGRLVG4wRDRJN05pMmlC?=
 =?utf-8?B?VDFZS2hFbnltSzBHSFNMNHNZT3ZJemw1aXByRGsrZ3hHa2NrUSt2czc0dm1a?=
 =?utf-8?B?RlRhTG5VcXpzZUdVQ29ydm5JTGM5UnJpWml5UE12bEVzNGEvSmxRVlJ1ZDA1?=
 =?utf-8?B?TStCZE9Pd0UxbWVDWkh3cC8ySzdvaDVoNXJ3VGF5TVhwOTJqWU1kSFd5aFpW?=
 =?utf-8?B?OUR0RzcrbkNVL0Yrd1E1QjU1bkVlcm13NDh4ZWc1QmlFUEFCa2FjeDV1VXln?=
 =?utf-8?B?eExLTEs3cEh3a0JvdU0rZVZhZmFaQWwyWmo1V01zMnFlTDQ1ZUtKR1hVWE5i?=
 =?utf-8?B?NjI5cG5rOXlwRExBZlRxaWhQd2ZFYjZQcTlPb3h6VnF5OHpaSng3aTN4TGtL?=
 =?utf-8?B?OThGb3dWNzNIWGRBaXVUTU0wRXlvci9tZzc1ZTlXbjI4bms2d01iSnBKQ3J5?=
 =?utf-8?Q?znQ4dO1MvF9BmT9kDB8jq10RP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f60bdf9-f2b6-4025-ab2a-08da641af296
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:26:53.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOSSahkHRTlQV0jCQZ36zOzsd5J/q2/vDIrd6DeuOD3jOY1cGdABGMJHHA1KxST6wF9piiHTcAnzXry5jW2+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3356
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
Cc: kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-12 10:50, Alex Deucher wrote:
> Ping?
> 
> On Fri, Jul 8, 2022 at 11:50 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Not used outside of dc_dmub_srv.c.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> ---
>>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> index 832f7a4deb03..39b426d04037 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
>> @@ -270,7 +270,7 @@ void dc_dmub_srv_drr_update_cmd(struct dc *dc, uint32_t tg_inst, uint32_t vtotal
>>         dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
>>  }
>>
>> -uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
>> +static uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *stream)
>>  {
>>         uint8_t pipes = 0;
>>         int i = 0;
>> @@ -284,7 +284,7 @@ uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_state *
>>         return pipes;
>>  }
>>
>> -int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
>> +static int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
>>  {
>>         int  tg_inst = 0;
>>         int i = 0;
>> --
>> 2.35.3
>>

