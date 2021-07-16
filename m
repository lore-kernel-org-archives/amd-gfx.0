Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F1DC07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 14:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E879613E8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 14:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E879613E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BE66E9AE;
	Fri, 16 Jul 2021 14:06:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F476E98C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 14:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jznJx5ty3xdDDHjR0RsqxjvuvdZ6CzqTx0QDZF+NtryQR5aAgjra1V6XC5JBYoxQDbUPRPdfBRVNSBevFPD2Bs6QtG2MOmcrtWF0IEBlF8Aqv9iA8JmkPvBIXZwvn7XlU1KqPvTZqJ+v6bOiSV3jBwRMTQkkGTdeS84WdK2YSsr6xpSqolVOT++ZykApBt65yh7sVQ4wF/TrnAInTKjDzVWbAh+mcDZFKAjPIATrPMr6CWc/88oMgoj3FKjzQkG9vAPntO/fyyiMXorYGkHmLqDuwP5S7t6noVq/b5usmaKK3QIRiyuG4EnL74OsD5wSfn6zgwUJTmEWt2WJrEsJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL5eX0ZlqKDRQaMN4+qabA73ZLO3sySW9OdnVZ7x1N0=;
 b=Yzzd1YGFKL0pZQhbPjQuZYQbhW8/DQT8CDhczzrCXH0s0qfmE7T2lf0ISf7rqmieTOo32YJ09sPfvNdmm2LbFp3EbdXO6pM+pbP+gSpo+T2cVegdFxNQByWXMjAS+t1m367MLZsgK1hdCP5urAb2TRVIkNobO6HXAcoMrHIhKKtC+qYN3V15LTyYGFIHs/UHSpDVPWvt2pwTw/DjL9uikyyrQKnqJHcmvyeEhDk2rwBqEWSpQ8ZTYrNKj0425UQcJaj2vGuijVi82/afEMCpdCWp84PydNAK2bts9nsH+X1Qc8Z/1XVItDrPdwsiIcmaSiLiw1XCpBGLIszPeG9jcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL5eX0ZlqKDRQaMN4+qabA73ZLO3sySW9OdnVZ7x1N0=;
 b=ZFvtPi7XO7OegI1preR/HK4q0HTIbZueP6Yhr62oWvKPL+2jwm236yafz1EFMtIq1wXIekfy5hsqPXUVF5hBK8IvTtc9Z6oFQUX9haXrLIdW0TPq7D4t7pulY0Dn/Nz6AA+AFxvkNLDTYp0LE31rfIyxdhSjVjt4Gl3ao2uCV7I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Fri, 16 Jul
 2021 14:06:09 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4331.027; Fri, 16 Jul 2021
 14:06:09 +0000
Subject: Re: [PATCH 4/5] drm/amdkfd: Set priv_queue to NULL after it is freed
To: Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org
References: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
 <1626399273-21347-5-git-send-email-Oak.Zeng@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <574de535-e57d-db7f-e6af-d9d99e8d1044@amd.com>
Date: Fri, 16 Jul 2021 10:06:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1626399273-21347-5-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::29) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.84.51) by
 YT1PR01CA0150.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 14:06:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de3376d6-6fb9-4bde-3baf-08d94862dc49
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51309420F217F5DDEE2866C092119@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X01yFM4tQgGEbb+OZxdOnaR5Er3n0BaUUD/hlMd5/cMfF+5gAfGZqtth5ng0ngBLeGqg3lsLlzL5TwoOJL/k1FtPQ6C6z77vzcK+VVfRcONBehjdy2QMPPTq+k896rMH6a9gQECKtGu/TBWGYNMPoNP2181buNaNSCls3bqbaXmhVPN6GfpY5jqlGI+0FCRFFWF19bVFh5aAB5/jQQxIdL5yrphOmMZvmv7ikJW+uB+Jcv78k/JTNuGkF46vov9uZ6MxI7UFpuDMrcOylQkEnR45FSTac2NxiAhfkCPiBFYP8y3txQV5B8I1HZxWOlOrLYPrh2hBFAbQqexEpwo3S31k6OmxauuEgnpVlBlhPtuNaRBI3lfjTpR0muN890kJE4lt8klb5ME7jl5jRTcgBOR3wCCCSYEtxYNfg29BGTxS0UeJxcbYLHxuneHqwJVcNa78itNesfln76bKrKSSFw/SyupEeCG/nZgKmmYQBj6qUQB23RMR4AQlNT10g/Q1vyu1qG13lWyVuZZemYy88KsLcd4GwevxqY5oGvkPNMIfDk4l/aXR4cK8WQMGqhzfdDZPh7T4nAOminBzmAUCk5Vk9cgsCUuP9yBuPlWnTxg8SMLbxJ/buZHfqsgJ4vtaX5iC1QI1qQecOl/iw7R3ZwZkIB32T2bYbxIpePIkw5YquBzkqFusy6kF6c0BBtnM2kNq5vbCMDUvejIBB6Dk3UFRX3Ti2YEzeNVZu1u402Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(8676002)(31686004)(8936002)(66556008)(66476007)(186003)(36756003)(16576012)(316002)(44832011)(956004)(4326008)(86362001)(2906002)(478600001)(31696002)(4744005)(66946007)(26005)(38100700002)(6486002)(83380400001)(2616005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmYvUUhSWG9MVW5EVWpKNTRqNUp0aWxqa2x4aDVUVnRIdk45YkxNbjM4Rjhk?=
 =?utf-8?B?TDg2UU83c2dHSjFreUlaMU1qTzFrb3BGRWlNUzVkWlYvOEt0VStqbTdNUWxi?=
 =?utf-8?B?MzVDSDJhb3BjaTJ0T2p5Nlo3R2NDc3I2VVNFZjFxdE1RQk5TYnppQTlVQ0ZX?=
 =?utf-8?B?WWlwbm02OU80OVg4OW94aXUwMEpzcVk1RVc4MnJvTmVNcnhrbmc4MVkxejBx?=
 =?utf-8?B?TEx2eXhlTE9Xa3dKakpBZmZCa1hiTjhab0xkWUV0dVBtQ0tDaFVmb3N0aFRM?=
 =?utf-8?B?N0Erbm5Vb2VEWUlZbklheUtsaXkzaTR4eHNIZXdXam1IZDMzOFBscDBZaVVV?=
 =?utf-8?B?Z0haQlY3cjVjUkZDVWd0c2VHT3E5V21wSk5rK05ycjlIQzZwSTNhUDBhL2Np?=
 =?utf-8?B?dzRrc3c3K1JJUjYyR0JNUVFNbi9rTTR2dktBeGVFTGlNTW80a1pNdjN3cXNX?=
 =?utf-8?B?ckVPdVd6SGZFMnNXWERCcGlIQ2xPNDUwVUJpQUd2WnkydFVCaEZzRHpldEhk?=
 =?utf-8?B?eW1oYzg0azdNY0REbHJxZml4d0VLbGhZSSs0bWdXMm45MlJ2V0lqVE5jOEx4?=
 =?utf-8?B?aGFtQmltRkxlUjhYdFhWNEREdVlsYnU4V1NNMGpOSHhTZXZBN3NURkRZcmhL?=
 =?utf-8?B?b0RmOWwvMUZDR0IwTzBtQUZFcTViVkt0MmU1NlRUZXRVSk8rdENva3lpdXcx?=
 =?utf-8?B?SVA0K1gvZG13QzBSbWdVcDJneFRkbkJuQXZRTVRVN21FaWdFZWhGOUpqUVVF?=
 =?utf-8?B?anFqOW80bWs2RnM3d1RTcktZRGdtL0VQb3ozbFc5anJzRW5jdkJsZnJEcjRV?=
 =?utf-8?B?Y2RBc3VRdkoxUnhleHpKMlAvdTFQYzRsNHowNWxYLzF3M0xJU0hDUDE4eDJ4?=
 =?utf-8?B?bi9LdVozcGZSWUZNYVpsUlRKQ2Z4cW5zRU1kd0pSc3lEM3NZN2VoYktlTE16?=
 =?utf-8?B?Vlc1NjdwSS9hekZ3WStXR0dTZENXZkxhejdqaG50SHRXbXUyMnBSeTA3UjVJ?=
 =?utf-8?B?Y0RydUxJL1IzM3dUZ1YzUHdOZDRQZ3c5amF2SlVzNzZsc0dSODJxSEtKRy9B?=
 =?utf-8?B?WG5ibjdXTjJhMnpYbm9oUTl4ZElSczBCbnJzUzN5MERHcXZuVEZxMTdZTXVR?=
 =?utf-8?B?Sm9TUmYxUXJoRDAwQ0JhaFpUbCtWbUFPMktvdVBrRjdHTGZLWkFlL1ovL01E?=
 =?utf-8?B?TW1xVjl5K1dTMFBKQ2lnTGRUKzl0SndyWmhRa0RibnB3YUxFVzFPN3lYTWhZ?=
 =?utf-8?B?SUthM2JuY3o1OXN5L2o0QzdNZi9IdHJTWlM1dzNMME5xMTgrZFpndWFsMzNx?=
 =?utf-8?B?OHpRTjIvRTZuTTQ5MGdmUmlucTI0TE5XNXlOQ2NaaDBoMWRQcVRHMW96S05t?=
 =?utf-8?B?MkpNVHR1Q1k0UitBR0NOclYxU1h1SnVzY2FQN08wYis5QVNscDd5T2loclVp?=
 =?utf-8?B?T3crSFA1UGVGd1JTajlsaHlseFpMaFc5dlJjZ2w1UzlvV1dqS0ZNQ0FVRXNx?=
 =?utf-8?B?NE8rQnpuaFZON0xIc29Yc2J6NHpoRVBnQXd1SVdMcFR4dXFGbmVlQnZ3Vkor?=
 =?utf-8?B?LzdndHBuQVViRXFodGptMlk5ZWM0YnA5M05SaXBQWWNtSHVRQmR2ZjdvREps?=
 =?utf-8?B?WmF4MEQ0dGtrUjB6c3c5eUJZSURHdjB0RHkzdjNDOUJoN3hsZUFBMFhPaVZY?=
 =?utf-8?B?SWFuTHlQeFoyN3h2OWNOdEFyVGtrbXd3bkN3Vno1TldWdEFNYUpWMm1jM3hG?=
 =?utf-8?Q?n3ymzrEmpcjPVGrbyUnmd5OYp/26CdHitEvGgSi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3376d6-6fb9-4bde-3baf-08d94862dc49
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 14:06:09.0702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTQ9fXNUpfLbMEd3GP3ppe7mv3H0h33fAHblk3k1zRPcxhP9By2tJy4hL2aswZQc45nkLzQIo3JJ9OstqBjSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Cc: feifei.xu@amd.com, leo.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-07-15 um 9:34 p.m. schrieb Oak Zeng:
> This variable will be used to determine whether packet
> manager is initialized or not, in a future patch.
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index d8e940f..b130cc0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -278,6 +278,7 @@ void pm_uninit(struct packet_manager *pm, bool hanging)
>  {
>  	mutex_destroy(&pm->lock);
>  	kernel_queue_uninit(pm->priv_queue, hanging);
> +	pm->priv_queue = NULL;
>  }
>  
>  int pm_send_set_resources(struct packet_manager *pm,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
