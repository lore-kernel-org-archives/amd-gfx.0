Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A4C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 21:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4EB61D8B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 21:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4EB61D8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C232E6E8F9;
	Tue, 29 Jun 2021 21:03:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20946E8F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 21:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pwh5DGbY042Bq1oXb0VmU++sMLW3BkLXJarleGvEQebDzcSRc+6trImBZz4ZR3jGkaVQFMkezbgNsIyV2dtv4muklo09PSRxwZr9EU7dwwMvHqv9/64+EoYZwCFUC0EOYDJ99+Tx7DNuS74vgDoTtrbTqCH39Z1miLaakLcyiedDwkaz5kU9i5NL+snLN/syobFI9BOEh3C4Cr7QI21kJ/4CUcVt9mLMZyhjs0X1p9cPzytru2RQxTgnMclJRKw9OxdhGhjcjc6JYlOWS5hvmXhiQ3GZV+AQW7C6AufuUz4/XAfUY5LJOiJ6FN6zrcAakV4xzFRPUhL+x3+qqHRqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfncXZoVtDmCVzhezlpVKyK7AKlNl+eRnU7dhp1Nh/k=;
 b=dPrBaZJZ8O+Ae+dWZo2axxa9j1St2UNnxEJwVhLLQSLaUQ0qNhLRGhPiDNFFRcIVKpttVsPcNrBTDvtt/VMJmzt21WupXN8zKPH1iIlRoLkWxB1tbKTfIadIKbMXefm47X7J1UErwdPvlIiOkpeAxpByuO7aouqJbKkILepFThmk0s8xEieEbSyvqevZdH9JrNLdC9oIVFwPe310LYhJQ+dQciWONFw1AbQAOHG3eqOuGaUH2J/8cu/7J8avoxJclFkPl6dhHorX1BTVxjjV2o37aAgCDkvCPh0jrMzGq0ixDyQehjfnl62H1R/Wa2cbHoDc1PyBPjNd4N4yIJtFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfncXZoVtDmCVzhezlpVKyK7AKlNl+eRnU7dhp1Nh/k=;
 b=SYMYyr9SLrcJIvPuxzkTQeacKymmYpyb5zLMnaVuVa58rdCycO8MZSENKVZUWXA28NKsSO9kDjPGxq8iN2cFpngYA3+FEnZXBFAKn/V/ARB4fmWmYO9knpfHL7F4IVQGVlYlhWXGvqX68WVU56SCYdKPDDTna6ffK0c2hkA5uQk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Tue, 29 Jun
 2021 21:03:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::401d:c7a2:6495:650b%3]) with mapi id 15.20.4264.019; Tue, 29 Jun 2021
 21:03:25 +0000
Subject: Re: [PATCH] drm/amdgpu/display: drop unused variable
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629210228.362806-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <56e429cf-e990-a1a9-280d-141dc5e2d166@amd.com>
Date: Tue, 29 Jun 2021 17:03:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210629210228.362806-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.154]
X-ClientProxiedBy: YQBPR0101CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::31) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0158.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Tue, 29 Jun 2021 21:03:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40851ebe-8f7f-412a-657a-08d93b415616
X-MS-TrafficTypeDiagnostic: CO6PR12MB5393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5393A947BE9ABE5DB72527218C029@CO6PR12MB5393.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d7Ia91V93wCykFiZpfEahj1kNaQihFQI4R37tn2yscTmK/+dHQenRwG0azhE/klE+V/TApxAIyUHDDXNyf/Lnsb8lk+oHhv7Paqp2KwszDOpm03th2X8EzaVm/55kQgSItp1RQMQpzXxr2QdDjV9DdUTCLFjoj9OULOmvvp57HgkpeZO7k0hzM76wpKWnwD+AuegJSdzvWIhSeKTFxxYYcpPQKHmU1n1q8JmhNvXeCEYoVt2EiqfvQI3di0tr+SdyI/wH/LgMH7TskeHb7tmsJmaooxNnO75edS+JKbGNnSXeqKy4mon1xJaMZfN1DPAnON+MCwd1F0AHHXy9hVdKuNIejKtiH1fynL2Gb4nYk7MrLTxT2jGDWUHelHAJQGDL+SVbHeBa+MipdTH3fQz2pqKFWS/bloXA31N7NKr980qEb9XWiQ9qT8FXRc9/kBitJDAnAmzlDH+rK6kjOAoDX3f48avzEo2u8oIxeFrEO+7S1UqYUbrQFML7u1A+4+CT5qGShT0+2cNAtp7+99g1L7qXWGPfdz4ht70ERJcyVRHDmw4gu+yD+isPDRhhwY5UivEdtiHhd3cKBHOh3YKUf+dC2774nW0aViVPOWzmLK80ED9EkbaqDdIpWYecTtvnrmv9C5qTQpTDd1sv7lXycz+uRgIedTAZViZrynkw2F55kxQsxVzmWPOr+bidGqDVQQEQpqQ804S+A+vnakGoDj8byeeS1FBp2Ui6Jscpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(6486002)(31686004)(66556008)(956004)(2616005)(66476007)(66946007)(38100700002)(2906002)(36756003)(86362001)(16576012)(316002)(31696002)(5660300002)(186003)(478600001)(83380400001)(44832011)(26005)(8676002)(8936002)(16526019)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVkvWlh5VG9zR1JIUDc4ZXBHb1pYZ3NjRjBlNlgyN250SlFqM2QvOG9Eek9Q?=
 =?utf-8?B?U28zNFJlamE3RmFTQWlkZjhLQ3dSWjZmR0R4c0EvbmovKzFsMm8wZlFOOFli?=
 =?utf-8?B?UUVqZnhkT3QzUUpFNSs5WS9CRlVYNGd5bGt1OW9DVjN0Um9GYjIyNUtvRVND?=
 =?utf-8?B?dm5vaE0yQjc4c09md3FrRXBhVXBzV2xDMHlDRmRZcVBTNHpQbUIwWExkU1FF?=
 =?utf-8?B?QVVZbWxmMitLREVxOVU1YW1pWEMrc090L3FYT3hBNmlTMXUxK1JXNHN1Lzdz?=
 =?utf-8?B?aWo2eGF3d3Q4VStiSXZGcDJ3WGVrQWdXcVZKVFNlNlFsS1pPdFhJREtWZ2xk?=
 =?utf-8?B?TEhUMi8wMFgwQVJIZkQ1c1dSUlJYY1ZIOWdEUm82YXdLTC82bGFlbTNXdktZ?=
 =?utf-8?B?bTNoSVZRdWc4blh2cit5ZGttSWYyS3VmTTNHR0VHeXZKeXVWdzFvejZzcG56?=
 =?utf-8?B?aUR2WFR3emZsWkhjNmNETXVmenVzSm1BdWFCNmY2R0VWWDFSV3BONFlES09G?=
 =?utf-8?B?ckVSQUlzWVQ5WFh0MFo2STMrajlBUGZTemdMWUV5WW5aZkdUMTIvNGdkNGlI?=
 =?utf-8?B?dnpITjJucjV3TlRDaFFzcDVuMldwV1c4b3RuYXZqWVl3SFRtMnFnWnlFWFM2?=
 =?utf-8?B?K0RNcFJkMXZrNnZGb0dxcmYyaEt6ZmFCai91T1dzNlZQTzkzZkprYjJRclBa?=
 =?utf-8?B?cXpkTkw1clJJUEpSYlBkTGpVU0ZTK1pEV09VcnVLclo5NlBKMFdmcEE3dHNr?=
 =?utf-8?B?T1JVZkw1N1dkanJwdno0UEYrT2ZvU3hrQ0R1Z2Zza0EvbTkzdngzR29Pdll3?=
 =?utf-8?B?QUY0NHczNE1UemhRYnBJOWNHZzVkM1poa2tjL0lTSVQxaXNjTzFKY1NhT2Iv?=
 =?utf-8?B?Rlh3bFpPamdXaUJaNmg5MVpmcTVuRTVwM20zSlZZMkQvSWNZSE5Qc3pPRnFa?=
 =?utf-8?B?bDM3V2U4YVRBWkNoMW5VZERiOWprQS9sRXU5UDFVQXIyT1V0UXp3QWZxemtl?=
 =?utf-8?B?cThqaU1oS2tiQ3lQczJDNTJGcjEwNFdXWkMwaXpFeDdKZGZKbjlpNVVSMWZo?=
 =?utf-8?B?eXdPTEowTTZKeGQ2VWFXWXBRNjVyUmU1SFB0NUlyOERRb0o5N084Q0FKNkV0?=
 =?utf-8?B?cHdiUTljUGNMOGU3N1JmdUtJY29JN3ltditNeUtxSDM4andvMGNNSWZ6NU9Y?=
 =?utf-8?B?elFjZ1ZNSUN1Q0g0eDdUWnhOekw5blF2Rmc2TDByRkpPOXkyeVNPVUhyZTBY?=
 =?utf-8?B?am92d3VNOTZ2VzlVckVPZkZrZ1FhWW96TStXOUJxK3hDNm90U29xbWJsMnlo?=
 =?utf-8?B?cXBVRUJuRU1BRVJ3TzBJNWFmbUNodmpoQnN0NG51OFNxTUtOTVF6T1o1L29h?=
 =?utf-8?B?U2JjQ2VnNUx2V1BCTlNEY2ZSVE1UVTUyNHFwbjJoNVV4UU1JOFZkZ0hPUDNE?=
 =?utf-8?B?Rjg1Y1B2QWlCTTFmTTRXdTBZdVZrQjY4Sit1VXBQOFpQd3Y4eVNUU2RGaUU2?=
 =?utf-8?B?RklLUldNMzJnRU9VMitoYld4alZrTkNvWS9CS29ON2p2U2VIYzVWblNKT2dR?=
 =?utf-8?B?WXNxeUlCQWsrYXp1QXlwZEdQRW1DbjNZQ2lBTjIvRW9PVGtLdUVUWWoyRVBK?=
 =?utf-8?B?R09pTlZ6WDRDODRoOUgxSC9lWm1kL2pqak82bHFHOWlPTXZhZTBad29VUlhJ?=
 =?utf-8?B?L2RXSk93bkZERG5kT0JzMU5jK0wxUzB5ZG53RXAxZU02V0dsVVJoT09yVUdz?=
 =?utf-8?Q?yJQVrf0lkuDDXNrE62nS4LF3mdZnazDVZdw3yKF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40851ebe-8f7f-412a-657a-08d93b415616
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 21:03:25.5296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh5F+Dy45TFrrv6gf7gyrJX2w5qBIJjNvvFNhoywB9V/GEDS1VnvBQQkW+7ZU5dMQWlgRJE5hxdwomI+Fgh4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-29 5:02 p.m., Alex Deucher wrote:
> Remove unused variable.
> 
> Fixes: 00858131205f69 ("Revert "drm/amd/display: Fix overlay validation by considering cursors"")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f14b5468b7ee..e034017daa1a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10221,7 +10221,7 @@ static int validate_overlay(struct drm_atomic_state *state)
>  {
>  	int i;
>  	struct drm_plane *plane;
> -	struct drm_plane_state *old_plane_state, *new_plane_state;
> +	struct drm_plane_state *new_plane_state;
>  	struct drm_plane_state *primary_state, *overlay_state = NULL;
>  
>  	/* Check if primary plane is contained inside overlay */
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
