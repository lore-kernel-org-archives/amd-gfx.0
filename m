Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F0BC5478C
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 17:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027C810E409;
	Mon, 26 Feb 2024 17:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2TnT4RmY";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F219910E002
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 17:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCdr/glpGeQcUdX62ufYGP5sqiHQmoiAdU/AhfEPMeVx+UA/0b0ZD8BPgf545RXN3lf5Oo/e0uJU3HMkCVREf80PIEXrg3ZikgRqlBXTjLlrMObn/Vao/tRXrLUfn8XbIUbdpQrMCydjdCg7aO5iDneKoZHHLBCrMbQolqdEheqW7YvT3v0A0UJFjkeZCm4efXb0K5mL0u1wEt9coQc4bE9DnQDpHaLemdZ0zWQPbKsZ01PNBKPHF7zoqdvmm5uOeBzKL+ugTwumL0QekEHQZv6wnMshxK4qUbecwvUvHvefg7Kpdr6GWNHoXFT93/VcGZ78Sef3XM83wWnSBZHf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+y8aAsZj4GZx/4P2RrxSt6etToyZc86qxg8hnD/zBQ=;
 b=eftVHl3ELVPe+XK69fw/Wnpxqt0JEEITWMY8aCWfq3iPN9ngf9S4U5jQLyLT3SMtQ1h0jUkb65OQKnRKXGv9qejVn7rzv3qsY4PfIHRRpe3tS/7+DqD38I3swzS4xJSTEv/UVBx8xakflPiEQcTw13K/WFX2ll5qAZFqT8TZiGDy0qRHLgk8rKPl7SIyNWiYsC/mYPPWx7oV6BfspDH11U5DsAosw6lDE1OXc5ex/PwaYKipphdrolBN3/+RVpzucUMJ5tdC6KzyiNjpaqn0Bi9WEpaBJpwsaM/3yI9qK3TO1eUfcyMzBME72lXunWI6mNLgccT8hiqc4SRpvFTPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+y8aAsZj4GZx/4P2RrxSt6etToyZc86qxg8hnD/zBQ=;
 b=2TnT4RmYjpbvw2DAtp5ihCs4Sj2Go8DyJTRnCotgbSzhfIzURUB4+r0jsrbHL91jS13AHidhuUVdJpYatSuwnOq8lIKEtW/bXvLLHHvcJoXyUkEWazUpRBf1sB0Q2pYNKgH06V7JjxiKwkWP3Rhhh6ApLIVM3gzTiHx3mEmncOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Mon, 26 Feb
 2024 17:47:21 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::7309:cd67:8037:b9a9]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::7309:cd67:8037:b9a9%3]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 17:47:20 +0000
Message-ID: <d4063eca-67b8-d4b1-b652-a8bf58b2a130@amd.com>
Date: Mon, 26 Feb 2024 11:47:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdkfd: Use SQC when TCP would fail in gfx10.1
 context save
To: Laurent Morichetti <laurent.morichetti@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240223220830.1830131-1-laurent.morichetti@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20240223220830.1830131-1-laurent.morichetti@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:805:de::46) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: 38061d19-edaa-4f18-31db-08dc36f2fb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Al3DTgT3J4KW86qAn4Cr6ChmtSKcSfKc+smpt+V3VeYxGEHvvfsXXiFS/AEf3P5RS8ugpGZULHnlJziIVesNOS+iSawIs4in48TYMkUq/6Ffs3cxfg6fGupX47aNqRx5JoAvWkB9/3+9L8uXH14/zF0adrRUnHxNMwLRINh/tyvqWt+4jMFcZECbNNPr/2mOq5AxzRGnKs8lbNqIcvq2PT44goTgJEOQDajHUnDMkEoaMkcJl+aq8raX2fJPvzL0/dgev86BPd20JRc7uktZIHrhuhiSNxZOZGnbIqVf43tI0iZ9eHmCY4QxXk6IzkEwzvuvZpR3wEmKNbpCB2IJH6EE0swWVOfA30CLlgT/AvTWSDAQdLCzwqh3syRlaXQcvqlmLvYBBR/UalayVLEj/DrA8bJcnlq1Gyo/VyggmI06vfwrZA3imfAnHG4wJD1kN/QwueQHb/Y0NrcsJJmQW2cKnCI9vFhKr4ilI/o+9RRUxoIKdkWre9i1qmhm/X06rR0De328SI3IEbVCWCWdekNrJ715DQDcVlY2+LLhBBkYPaj9b83e2xhYlOeZGxvrhtyjARK68W5Oss7dUI7uTXnVcDGcz7J0dZQjnFzaVLUOVQG1iV9O13UsKPBTxGpR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk1vZmJGUytMbjUwUzBDekhmL3pqSlp5bW5YaG9mMzVNR1VVZzZ0L2R0NmRr?=
 =?utf-8?B?U1ROVVAzYzgwVTZaM1dyekgxdC84YWxmc2tvZWdCMmxZYis2cU1RejRJVHds?=
 =?utf-8?B?ZjJINkRKUTVVR3VGNVhtaXFLaFlVMFBNZnl2MXlaek53Uk9nWUJhTmw0dklU?=
 =?utf-8?B?V1hzcVJxM1JvbW1TWVZDRTlPcTQ5cWJlQ1Q4aGtLQkVBVzFEOFdSeHFQa0Ns?=
 =?utf-8?B?d3JlNGQyekZOTUFCUkFsRW8wNFFMYlVZeGt4c3F6TTNGSTl2dGxKU2VjdWRO?=
 =?utf-8?B?TnBhekJ1ejE1MFY1YlJxY25zYWM0b0tkTDR6aGNkRkQ3MTZTVGR2eUVEYjBw?=
 =?utf-8?B?amhjVVlNTzdNazVIa2hyL0UrM2xLc2h6enJzZ1ZuU2J2Rkg3ajZxcE9oVFAx?=
 =?utf-8?B?bDFLNnExQzRXR21QSmU0QUFjeStPTGhmRkhudG9RWTA1K1ZwS042V3VCZHhE?=
 =?utf-8?B?MTR3QThDV3R5WmhFM1NsTDBma29VcGhoUVZpOVJCYWo1Q3NNdjhWbDZMMFBU?=
 =?utf-8?B?QnBBaWppUHk2N2kzTjFTQWxBY05hVElPU0tBSHJldmRpcEhGRmZvOWEwUmU0?=
 =?utf-8?B?eEQwb1FlbksrckZqUmZZMVVyYllEeWNZOVJZRDNqck4rZzM3WENLTHRJYkxJ?=
 =?utf-8?B?Y0xHRGFUdGVjWXNoajQ0TTZBdm5BRU0wMGMwc0Y3VmhCT0hqd2hyZTRKYjZy?=
 =?utf-8?B?S3RZWU1Zc1p6MTYzZXY1NUwxcmUrWitLVXM2N254R3Q0bVlUV3cwM3Y4R1Vp?=
 =?utf-8?B?cmdnRDEyRkpIY3hMRml0TUttZHQ3cjQxcUVzWmZ3MFFpNU9iNkZTNklscHAy?=
 =?utf-8?B?dW1mdHNrL3MzN2FveFB6ckVaelI0d0JPaERLM0M2WU1JVXF1Q25OOVZKdFIv?=
 =?utf-8?B?VDNhSi9YbFRnV0ZKcDltbmVZc084MVp2K0J0Tnp1N3FucHFZY3g2VERhUElr?=
 =?utf-8?B?M0x5QjJTL0VGUXY3aVhuemUrUDI0SGRtZFR5c2xadzNNS0N4ZEQxa1VQZ01C?=
 =?utf-8?B?eGwzTExCWFYrRFhadFRZb0M0NjE0M2JCa0xOcVN1YjUvWW1MSFdvVnNtNDQ5?=
 =?utf-8?B?bHM1bEJVbSsxM3lkK09iR1ZIZlZnbUlkalFLU2k3dVdpYnFGUFM5c0V6djV3?=
 =?utf-8?B?Ykxwb2RaYXpOSHZuVC9VSWtpWlpNOXY2NEFsWTJJbXFodFJDdVpQaEFjY0JF?=
 =?utf-8?B?bFlwWWxuM1E4UGZoMkF6VmxIYWhWMU0wWXJ2aUdBaWorSXZXOGZoNmVtOXpG?=
 =?utf-8?B?Si95RkxWN2JGblhidnlOd1R3UlFHRFc3VFQ3NUJoN3JkaVkzRDZndmg1dTdE?=
 =?utf-8?B?V2F3dFRtWFJuZHUzamYrMzMwTVhrWXl1MXZWWUlXRk93Y2hIVkR5cCtDVDdu?=
 =?utf-8?B?VkNkR2V5bDVUWC9zNlRlZ1pIdkEzVTh3Njk3NlJqZTZSR2xzTmdBQndHRlRM?=
 =?utf-8?B?RmZqb3NOeTlTRElHYkFTQ3Fya3FON0R2enhxQkJnV1RlUkEvUVI3R3QycUM4?=
 =?utf-8?B?aHZvVjU4VEVRMEJPV0JoLytrdE1sTmpCeDNYM25lOWFycHBKWnJjRkt5czY5?=
 =?utf-8?B?bUZqS091amt2YUpQUkFNYitIYVdZOEwvQmZDUFdwZUtwSnBRQW5jdDg1RTlI?=
 =?utf-8?B?ZU1BYjdEZnJmVHRFazNHYWRLTWk5eDdyUkVKM0VuNWpkNk5rZHd6akRDMWVh?=
 =?utf-8?B?eGxXYlB6cHBOMVBGd0F4Q2w2clRTVjZRNkh3cXV4TG9ZbnpHWVFlekVNZGtD?=
 =?utf-8?B?eWVqZEZTNmg1RUdXZG9sTGVUWFE1RVR4bTZpSWpaTzdCV3VtRXZRRDByZk1i?=
 =?utf-8?B?OVNoaHpuRlUvSWcyZFgydEVXZ3lwVmJwRy90djhjbWh5OEpRMk1oQmN2NElu?=
 =?utf-8?B?bC9ncCtiSGlyTFBISnNiemtRcG5TTXg5MXowWWhLTnFyMjYrOWhrOEpMVXdV?=
 =?utf-8?B?U0ZDdU1aV2kyRVBiaE9wcEFwaHl1ZGtHUmVGZW1yU1ZiSjlGTjQ3SWxlcjZY?=
 =?utf-8?B?eUZaL0wwRVdQTGdEaGpSUUxjS3Raa2p6clIxMGd1dTRua3JwOTlsZ211bnMz?=
 =?utf-8?B?Z1Q5UU84Zk5uK2hWSzE5VWt2UnIrbCszS1MzbGxaSU9DSmJ4aHhpU3o3SHho?=
 =?utf-8?Q?w1q5A0+A/XYydA4zhBH2jBXV6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38061d19-edaa-4f18-31db-08dc36f2fb58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 17:47:20.8862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPuemqcKzcTGrUia84phOHsOr4Qd1uyzMOrN49wOxMdlzPXp30TLJ+f8zKWK9TISLmC/Xl3b+3DUe3ftEfJ/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

On 2/23/2024 16:08, Laurent Morichetti wrote:
> Similarly to gfx9, gfx10.1 drops vector stores when an xnack error is
> raised. To work around this issue, use scalar stores instead of vector
> stores when trapsts.xnack_error == 1.
> 
> Signed-off-by: Laurent Morichetti <laurent.morichetti@amd.com>

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

