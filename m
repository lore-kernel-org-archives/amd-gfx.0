Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC901C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6620F61260
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6620F61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230156E2D7;
	Wed, 20 Oct 2021 13:56:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC6A6E2D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 13:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtUzUJiuPyWtvC34bmp1B4/5bbv17Za1suP6jp8WyPuhf9j/PRcDyE8qVUs7Ro3JcJFi2X0PJV0I8SXk7BPIY9NukPOiTlLsEHoMsXOFFZVh039NGMMivTQfdtUbmumF3vXDesvGJg0llHxyzjMEMQblkcHjR5JNNesCTp26A8w3n6OY8Bn1bdeZMGcjLqtDn8KoPeXA1pQpcC6J7C1gFHqBxQNba71szBIhvptBfCNKYji6NC9ho8CY3A/5cTQ/B4awliUJOrf7dGAgChvsYRVkeqdwfbdrDYAUqycsB6dgVPAUoH1CPfEIRE+lx5KXwtmkM06Qvd9SxvEcHppSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgVhGKlyVAWQ9tFkxQAI68TgaX7x6a4Amnah++b4Ikw=;
 b=U5zC5VgCYn4GYuj/N1PEdMPi1pjT3ktWLhoAsVGb9D9j4/TN8zHAxHbLswGCEeBCseMp2I3aQgaCvK/69gDPPeBl42Yl1C/bTjKPTea4pFYBydpBcr8j2b9MqmpGEQFUZ27UanhDs8cmo8tf+ofDUXMZnk6FDoUtd6bDKvWmrNG3irtfdpof1sYVfh0z3DT3VQqRYX+ZF5aC1iu+vxScddSXO81kysokzmTvbzm+E0uoytqjVDJQgbB7B/6MTIMASS/O08oRGvdY0RF3bli11IyEVhdq8TvEZI2+0F0+oyawvMNlTmJG4Klib3H0OHe6gHm1R6qxsoWicGA6L/gi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgVhGKlyVAWQ9tFkxQAI68TgaX7x6a4Amnah++b4Ikw=;
 b=zxN0L/BHtInowHAOMP7aFIXwsFSOBXtfbmFGco6+hIZFs3FRammyaMGyUbvIOCMpoc24ZTM3hbq3XCUG9CT9YZKL+FGhU1AjeZY82IFgIN799mk4jEXAHzwXCT5kG57iF70Aa9ViwW0lvM0pUHwmdLNkjOtnr/3p/8mpzBYRSss=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 13:56:11 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 13:56:11 +0000
Message-ID: <a1f382e8-91f0-9a5d-a54c-67c46eb79fb0@amd.com>
Date: Wed, 20 Oct 2021 09:56:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu/display: add yellow carp B0 with rest of driver
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211020135321.1011977-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211020135321.1011977-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::33) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0160.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Wed, 20 Oct 2021 13:56:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71da7bab-550f-41e9-0c5a-08d993d15f9e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5458CD63E7D91F28935EA4B68CBE9@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPU5cSfNVLBGuAgiZNflFjOlSaMFlvoO4DDE/UXZDOctMDk6SeGHBwi+wcrlOP1x6s0twG/tpuXFHZbNUvsokTDFDqk3Qhf7x6RaAImeUw/zYF6z5imuuXE3q8fF96qt6hKiz5C9+jRL2RwEFeBhEW62js+veZBXmmte+/ujA8NjrF748OQM3xwzwWP9msSmiISg9Fqs3gXpARhaZGVdA1kCmiDnwUE9RtCEaZJYr1Wg5kXdWd7cmvmqX9EWvpqryS3uRFEh7JZNmQRuYo7D6dzWc5MZfG5cUWaSN75R2uPfuOYnXqeSt+8P1fEJLx/+WLY0dD0zvlbEbmpEK4UbQmCr8EXJEktuOhvyBfiWymw/F1X6ZdmOv9RSFtnOKB2PZ0uGkwAw7S4Ng8WHqPfqoCQ5WJClRvymiebc/2ADNzeEcl39Xe2XWD5WXGbqLzx+4PcVoCbInzkrhKkCHhgASkFifNa6DuMp4gr+WFEsO9aAfTxSNt1i1MU5LVtkvccgp+4kokMBRiefenDEXmBv+SmFVq0ogL/htoiUEhMQ0CSi9P+pkikrPFB0juCZdjCF4pxJwb8HhKNSytvbnWe2DaTvzdjeoDzMTzRVSYWudcqGoQzefBvQqgpPgdlwNDlJCnfb08VTN1w9CrkManJcPXHYZz6tigS6QipOVwg3xwcZqU6O+HF9BwnNLvVh9XYtEfSfrRoEDuaAs4y94FBpHyv6PN79tMqsuR39EccsQb1p1RGHzMz0nKfN4P++yIOp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(31686004)(8676002)(4744005)(36756003)(5660300002)(956004)(38100700002)(83380400001)(186003)(66556008)(66476007)(44832011)(8936002)(6666004)(66946007)(26005)(508600001)(2906002)(6486002)(86362001)(53546011)(31696002)(4001150100001)(16576012)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZxRUlOZkVDSUNqc3FpQjhMS2IvbnJJMUpET2JiamNKUXhkc0wxWDdMc3V6?=
 =?utf-8?B?SjkvWi94Qk9sMXJvQlNxb0d5TVJnRit3ZEpTUzl3V3c1ZXh6R2FZTDhoR2ZY?=
 =?utf-8?B?amJQbkt1ZFdBUGJadE1RYXNnZnEzWVJLWlI4bkN1YlU1ajZaalQ1YkhpRVdD?=
 =?utf-8?B?eHphcDVZT3dDQU4yZnpERmlST2hubTk1SFprczNOTzV6bEVKLzZPMkl5Rmx3?=
 =?utf-8?B?cytvUTYzaG5YSncxWE5RYWIwdTIvbjdJbkJ3RmRFNHpic21zYnZPSXlMdXFw?=
 =?utf-8?B?TTFZd0Yxcng0UzdUUzltMGxPTWtadDYyTVNONERSKzlxRE5wbE8rd2hGS3BH?=
 =?utf-8?B?ZTN1c3hXSXNDNDdlbDBCd2wrd1ROOElEYmdOTVRLY0lVak1JQ3hVOTZQNXh3?=
 =?utf-8?B?L1RRcFplUUdnd1hvK2t1MG1EcXpTZzdtYksxQ3dadDJ4TVlvMmU0SkgrSEZp?=
 =?utf-8?B?K3Z6bkZCSEJCMlhqb1c1cWxLSHUyckpYZ1RWWGU0U2QrUVlyMzBlYkc1VDN0?=
 =?utf-8?B?d3d4b0hMY1NTbCtMQ053NlpMY3JQQStBY1J0ZVhiZ0ZGZjY5TzhwNWRGNkNT?=
 =?utf-8?B?SEp2WTlCTDM4QUNNZnZXREVwQVhsbGpZRlNVS2d6ZnpCTWhTaHFYSXNCWEdC?=
 =?utf-8?B?b21TSmlSNFVXRzI3emxCbmxZcFh2bGRoNGo3aW1ucW1OSVowOVBTSEsyVldj?=
 =?utf-8?B?VXZaQk5LZi91LzJVNi8zVzJZZ24rcUgzNlFRRmtyanRpK3luKzRzTEFERXBs?=
 =?utf-8?B?V0V0ZUJjVVhRb0t2TFpxVmZ4RE1pQVlkcGRyOFI5MUpCZHNaU2syb2hzNHl0?=
 =?utf-8?B?MnVKd2xEVFZvRnF4MjhDS05xVUtyUWFINllRVGdDaUtQUTZTc1pOU3AwZHI2?=
 =?utf-8?B?ZWtIRkJIeWkyZjBTUnVpQlpxQ1dRNGEvMjRhdnpTc2ZnUW1WcnZ0VUZBRW9Q?=
 =?utf-8?B?N1UwS3RiUE9Wb2E0UFJWeG5zd1pDamxDTEh0R0lxQisrSkNrWjd0L25nQlVw?=
 =?utf-8?B?NkF1aVJyYlBORW51cDdrU2s4RnQ2Yll6cG9VaCtaL1JZeDYwS3M5MGp1Z2VD?=
 =?utf-8?B?UjZGNnNJKzlzTmRpUk9FMEhYZUgxaDBrbnFObE1Pd2tSSWcxOUtRL2ZmUTFG?=
 =?utf-8?B?WUx2K2hnaFBDZ2RlaEtReTluM05hd0N5OFoxb1lQTkNIak5TMCtJYU5lNEJT?=
 =?utf-8?B?bG51V3RYemJYd2MyRDZiQUYvYnQ4RmgxMmRlNmJCaUFlaWplbU9HZnQzRjdq?=
 =?utf-8?B?dkVFTU9EdWZiRWNVV3I4UWVpS1lOMlVuNytBUjc3bkw2OEIyUVdSSndkVVBp?=
 =?utf-8?B?bkNtQzltcFhPaGJ1c3g4SzlWNEpvZWpHZENTRlZmR2JDTmhWWHA1Y1NUa05F?=
 =?utf-8?B?YkdMaWxTUksxSWMxazNEUVRPSlBzTWlvYjU5NWNkOUhRQlNFREZ4NkFlTlE1?=
 =?utf-8?B?MStIVm5xTWlxSFNESnhtVzBzRFBSdVcwdzlmN0xlU3JOZjFHTXZ1RXVuUUN2?=
 =?utf-8?B?azg1TzM3UVJGblpMVVBZenZ4K1RnNUhYVldDbHhTZTFHSmFYM2pOek16ekpN?=
 =?utf-8?B?S1VsV2VxL1pVc1o5V1BHRTFTUkF1ZnhIb01EOEs4ellGYnJaYy9PY0cyeGZC?=
 =?utf-8?B?R2lZZGNJYnNTUjJDU0xFenVtaGlpMlZPaDhGYTVwSm1XMW1UNjY2UWVxUWRR?=
 =?utf-8?B?S2lRRUREaUptWWxBbi90dHYwanFMOGNvS1BtZEY2bDRPVEU3RjBBS3RiNWVC?=
 =?utf-8?B?bXZ1UWZJcjVkMkViREZyK1VCRUlxWEVBc1Nhc1hCazQrTXBkbVBWbVFCdit5?=
 =?utf-8?B?TG5TWTFzcERacThncE9aVGN1VG9TUWU0MStUejNhWWxuUTB4blpqUTk4Y0Nw?=
 =?utf-8?B?eExuai94Z0xKSGEzSTVrVnlaY29SbXlIK1I1ckhUK3R1REJycDdPM1JQbkRJ?=
 =?utf-8?B?b2hidW5OSjNrU1g4TlB2OTBWOTBHU2NKa2pvdVlPM052eUkxMWpMaTJGSjRE?=
 =?utf-8?B?enN3S3p0OWRpemRjdFlhSVdpUzZJUFNwUVA3eUx6ZjZsUVYyeWx3MHlBNGkz?=
 =?utf-8?B?Z3ZaOTdaOEd2WXIrdFhqdHUwbndva3A2V2hsK3duRDFBekorQW1wajRzODM0?=
 =?utf-8?B?MXMvOXh0Y1p3L1NBZHllQlE4Y09IWHI5Z1NUeDRTQlpwS0VtdFdjWVY0Y21Z?=
 =?utf-8?Q?IvJvL+MyhFl2mfNG5mWEt9Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71da7bab-550f-41e9-0c5a-08d993d15f9e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:56:11.2989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SavDsGyv/nbRdr9VA59tsr1YhAj7qsRtIjqjEvYggJ0KQIPpvAJQQAIqYn5Qqb76ftonKw/dULgrR1z1Fulq4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
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

On 2021-10-20 09:53, Alex Deucher wrote:
> Fix revision id.
> 
> Fixes: 626cbb641f1052 ("drm/amdgpu: support B0&B1 external revision id for yellow carp")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> index a9974f12f7fb..e4a2dfacab4c 100644
> --- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> +++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
> @@ -228,7 +228,7 @@ enum {
>  #define FAMILY_YELLOW_CARP                     146
>  
>  #define YELLOW_CARP_A0 0x01
> -#define YELLOW_CARP_B0 0x1A
> +#define YELLOW_CARP_B0 0x20
>  #define YELLOW_CARP_UNKNOWN 0xFF
>  
>  #ifndef ASICREV_IS_YELLOW_CARP
> 

