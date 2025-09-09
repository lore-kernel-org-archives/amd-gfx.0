Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB172CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 14:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9EC10E75C;
	Tue,  9 Sep 2025 14:50:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gN/gvV/E";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1947110E78A
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 14:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shwUSdnHEwBuOxQtL0OyFtR031a4u/1F83Mcsl3lgi7xJLR4yJuqcW5eZob39kVTqI5MeZf2i5QtVt/Mimv+igf/bRXK4IzrUp67fuz9y67TkbSoS49CIlxjlc703pTUfQh3SS/pgB5eCzGmO5z7lwq8FxBBiRGVvL3xlKfwHJkdSfQUnLqs69JUVzvSQI/1dH51FS8PywXLiyyRp3jCB3SbBly7fBTtsRcbGnJ5XRDZD2Wpfjy6FZ2vsg1C3Qh7CXZ88tiTR/mTnx5wD2Ke7LI/04qbC7kfXhpWsA5c9zORQ5DXUtokhL6EhCiyhA0Zzjehs4cRUUnFdE0ykd61bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOdVoMlYO+HufwWDPKeu+brrauNtskg4TfGaRH/uAzA=;
 b=eyP+ARjSLnTeagDgsdc/B4VqoarUtNwqhXUub9hEY2nh3Xb9cNGZM9GKTIXnqhgDsQaMHBhwpxH6bfCDAnRaKgPje4argV50HlFRhwXRViS5VF8az870Hu5jqxt9m3M4nlj1Oe59JFhtNjvLxHn1FO3Xab5fdxU0D+b+40lsec8KPRKEprrezuhwVxMZzE2EIxoqPrwY0xaBm5hyZ+g3lSAAL5KERo3wveVQvtAgf0BuIx+e90fBkP19QBrQaXvU4SVp4yET5str7qnAvsIiNQB1PNnkGO9XXY4vfCjUe4Bats4lnK4phraShK9KrJKNLA91d4Kzg/CWXMkIZvkQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOdVoMlYO+HufwWDPKeu+brrauNtskg4TfGaRH/uAzA=;
 b=gN/gvV/EmEl5EJTrIpRU9dgN1piWScnHRZhA03x2nyTnmuAdj4cYFFYQ4kae+Hxt21WjSWcK/egUYTB8WH3n8II5Bz+aZBJKbFXxE6Em4tdtecXU7c4UcBNt3rrN9Ryv/iTYbb/uqW4D8/AP+bxmNHecL+DEZqNF1B0aHgXb1z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:50:05 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:50:05 +0000
Message-ID: <a18b2b22-4d43-399a-640e-704774fdddd3@amd.com>
Date: Tue, 9 Sep 2025 10:50:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] drm/amdkfd: free system struct pages when
 migration bit is cleared
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.kuehling@amd.com, philip.yang@amd.com, chengjun.yao@amd.com,
 jamesz@amd.com
References: <20250908161526.99413-1-James.Zhu@amd.com>
 <20250908161526.99413-3-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250908161526.99413-3-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::31) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 58129ecf-a202-4ad2-15c7-08ddefb029d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmR5dUtRbEpMd3l0SnFBR1hCNlBhMjd0ZTdBUy9VZHNXdUpHTzd0WThxTEtP?=
 =?utf-8?B?UEpmMXZORFRGblJBRW5UL01xSys2cHgweFY5RnkxSFVxS1czVGd1azdoNTFX?=
 =?utf-8?B?OW9DalVCaWI5RmdTR2wvbFRZVDN6N21RWXJ4SEJqVzhabEV5cHNOODhVME1u?=
 =?utf-8?B?ZlNHSjJSMzlzSi9mNVFjaHBwZ05IOHRnRDRJUlpXRFBYUXVMVWJZNXFaV2Zo?=
 =?utf-8?B?UENCNDZaTHlMTFdaL1JoYXlGeU1IdG9iQ1lDaFFjTkhGd0lHNXFaQzhzNWZK?=
 =?utf-8?B?WXB1YW5NNExjWWlGWlJUOVR1b0ZqUW1YNHVFOTNnZUllQmRZK3NicVlrQkRv?=
 =?utf-8?B?aEIrNXVvT1FORWpTcFhlNnlrL1BYcFlZcVk2dU5uNllJVHowUVo1NGsweThn?=
 =?utf-8?B?Q2NhL3A0bmlLUG1tYkU3cEQyL2FmRzlSWVp3cUxHc3UxNUYvemhPOFdZeUpL?=
 =?utf-8?B?VmFucHFMUFAyRDVycXVHVEN0aXNsdit6QzM4YWRZQUM2VGFEMWUrc3J6TFZT?=
 =?utf-8?B?bWZPZ0hpNGdiRU1ZbTM2dHFQSUJGK1JTN1ZyRHh0Q0toMmFEQVpEc0dlb3ha?=
 =?utf-8?B?Vk5xYnhzbCtOb0tVZFV3MDlPSlJycDVFdXpLUEFZSUtyaXZwSENJSVNNb2l6?=
 =?utf-8?B?VkNpRk1mS0NpZzdMeWhXSnNJcXN2eWlWYU1tTVJVMDlBL3ZoVy9vdWlaN3FQ?=
 =?utf-8?B?bWhOVU50MEtLdjl6bjRKWnlha2wyYUpXUVp6WExURk9JOEZxak9IekV1MTdB?=
 =?utf-8?B?VmU4My8wOWhWR0dPYld1RnN3YlpVVDJOMGMyVjhndHpRbDQ4T0Z1OFJMVkEw?=
 =?utf-8?B?U1hIYzJqdnVCcEF6cGNHMHdGR21uVVllbVV1OWFsVkVEZEVoMm95UVp3dEJV?=
 =?utf-8?B?K0lndEFuUlZDT3ZJYkZ2RmlvVG1qUjdJZHJtN0NFTmdEcXE4MEt3Q05ZTTZZ?=
 =?utf-8?B?WWV2Z0dlY0lzaVBIRTNkTTdpR1Q5WWRUS1JGK3g4S0tzN1BQcjRYL2JBS1Y2?=
 =?utf-8?B?eWhtNnA0eWs4dHlCbTI0RTFJQy9wb280c3puZGlyTnk5MXN6dTdnOVRlMnh1?=
 =?utf-8?B?NmxtVEFyaDR1RURXZWthczYrUUtrMC80bmp1YnBJakxmam9Tc3VvSmwrMDZv?=
 =?utf-8?B?Nk15VThaR0oydlZXaDdNejFWbE4yVU9IUGZ1WFJ6bElCSFVrMVZpN09UU21L?=
 =?utf-8?B?VENjM1RuN1BaM2ZyZ3ZPbndsYjlwdTMyb2tMclphbUtiY0hDYXh2djBMYUdk?=
 =?utf-8?B?ckl5a1V3Wk8rVXlQZ0VpSG9wd0o5YWl0blcxS0d2ZnN6NW9pVkJ1UXphcmNJ?=
 =?utf-8?B?bDdndVRyZXR0TjViUkkwR2d0MTBtTElwNGtwQjdQcW1CS05QWHdKVnh4Vzc2?=
 =?utf-8?B?T1VZUFF6VVdrQVZVUHpXV1pWKzdiWHgvdUNJYmd5T2F1bm91UERRSzVIRHBP?=
 =?utf-8?B?dEJFTXNGNkVkckRVTEhLSG5uSmNqM1JRZDcrUjhSWVZ0cENBMU94Ri9laU8x?=
 =?utf-8?B?V0tMZVpLdXcrVjMyWThubUQ0T3JzMzNqb2hLd3pzVGhhV29VTk9OdFYvSkND?=
 =?utf-8?B?ZHdRTkZJajV0ZzM5Mk50cU9hZmhHOEJoeVM1dXRMR05BMVBDYUZUOWtqSXd1?=
 =?utf-8?B?aHpFRnlwazNpYzNid2FRZkVqV2p2TElPdW5IZGN1SXZCN0JkTWRSUVJiZm02?=
 =?utf-8?B?NU0rZVE1YXlvS2VIMnFWbGJMMkVGekR0Yi9wTFpHWXQyenBFcGNCTjNKdkpz?=
 =?utf-8?B?MXpSbmRTQzJ2bjNSUU9uU0JnTExoMy8rTzNocHVXTHgvVy9GdlMyNHRKQ295?=
 =?utf-8?B?U01Ua3cwbmJRYWQvRjRCSmlES2ZOcWR2cWNMK2ZSb2lMaGdwRERaQmJacTEx?=
 =?utf-8?B?bHlLQytrWnpKKzZRUGdTUnBlRmZXQWdFQ29uMmlwakJ1c3g5azFsZjJYZlVH?=
 =?utf-8?Q?Wy5uHsBdfCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNoNWs1VHV6Tk4vcmxhRDlJaG91NTFXUkFwR0g1RHNOcGJYa2c2dWdmV05Q?=
 =?utf-8?B?ejl5UXcxVytqSTJtaGtnbnFPSWd0ZGVjTDArK21RT2VWUWJHcG5OL3Ryd2xP?=
 =?utf-8?B?Qnc3b1o1NGEvQTk2RWdjbTJjeEtnTXpUS21SZ3pUY0hlYWRwdGJKQ0xpNUo0?=
 =?utf-8?B?OVV1OTZWdUlLKzdSTTFDS05JTEhaWUV5djljd2p6VHdkUndoOVp2aGh0bjNp?=
 =?utf-8?B?RC84a0hJZ0F2UjVYcHprR24wOWdYTi83RFI1c3p0VUZqT3VRTHNWMHd1Zm5r?=
 =?utf-8?B?eURjeHNoeUV4VmxwemkzMSt5QTcxWTcxVG93Z2ZzaGh2dTVvam5WS2N0aFdv?=
 =?utf-8?B?ZU9FZnNIQVVxZndsOXkwMVBaM0Y3ZGMyaFh0L0hmazlZaFpsYkhiN1dBQS9k?=
 =?utf-8?B?eDBJcDNuRGZOYlhXT0twaHFEUGJueU5ZZVc3S3NjNUlUbU5jY3FaS29qaVRt?=
 =?utf-8?B?N2RRZ2J3SlpGODR5bW5LWnZRMEg0QmQvRlF0K2tOWEIveFo1QWN5M0NVTGtO?=
 =?utf-8?B?dHNwYVpYVlR3Mmtuc1loY3BRWElObXNUVGdZY3BkMVFkaVhjaWZXVjdTekhX?=
 =?utf-8?B?TTk2TnRUeENySS9OTHN5QVhNZzdjSWpzais2dUpFZnVYU1VwR3VSQTRZM3Y5?=
 =?utf-8?B?MTFZVW9jRHFqOXovMjk5RG9hb1JpNkwxY0VPeHB2czB2aHVlUzFZRDl3Vlgy?=
 =?utf-8?B?R00xclFxTUdCWitobHR3QkZ0cGFpcVEzSC9wS0lmZXVLTTMyQ0JJWXQrYWpY?=
 =?utf-8?B?bVA1dkZPNVRSSXpoUWxxNGxUR3VGaTIrWFNiUFBxV3Iva0NBZ0o0Z0dOSGtU?=
 =?utf-8?B?TkM3ZmR4VlhnQ1RnNmFwU25oSFhpcE96UXhQb0FmcmZoV2Q4WlpOaUpOd2Vk?=
 =?utf-8?B?MXFLbmpDeVMzOVM1VUFsUkY2M2lRODA2QmM4L1N0T1BEcVlubEFtc3JoSXFX?=
 =?utf-8?B?UEdNaGdoYlBEQktKNUg4T2VLQjRJWjZSYmIwRm1tNUo0bjRxWXhaajdkakJ3?=
 =?utf-8?B?SnV5UFZ4MjNPM3ZsVExwcnRsT01QUVNaNHY2cGx4a1F4Y253ZzBtSysyQUsz?=
 =?utf-8?B?ZUdMWFR1Z3QweEtjL0poSGJxVURVYi9iTGYzaWo2cGpiNFFySGd1M1U1bVVK?=
 =?utf-8?B?cTZBc0NyOW1uQnJCV0Q4dGlpalBDREpSeFRpZkpscStBY2xYRFRVQzBCTXdC?=
 =?utf-8?B?QzJEdUxCczZ6eTRIOE5RT2NmbkcyMlJJZ1F5bHNMend2UG9JSmJJaHdBTTBV?=
 =?utf-8?B?b20wYVYwSzdHNS9lVFdzbDczZ0dyVnRqY1ZQU3p4VDYvbzVCWTdIVEN4SS9I?=
 =?utf-8?B?OTRxTXdLR2xLODRNb0lnZmRFT1ZpaDNFejljWTBzRDY4MmlTc2JNSmxaSXFl?=
 =?utf-8?B?TVN0L0FWZUpKVWI2blgzQXZ6Q0ZJMzVuNXVUbnl2Ulc0SFl0aXhSNERsck00?=
 =?utf-8?B?QzhDQ0liS0piVXF4OVJQUlVIS0k0TFhMQWZvYTl5S2FzYlNoSHQ5UGhtNWJP?=
 =?utf-8?B?YmJkc0hmVUo2NWdZSlc1Ly8rL2RLT0dGQVVNWFFqNTRKMC92amlKVGcrSFBU?=
 =?utf-8?B?QTBlTXlERVduTEpWUmNqYTRETU5kNE5xRk9tSnpoZUJjNldSZEQ4TWdBQVM1?=
 =?utf-8?B?ck5Yc0dBRGZLN2hzMWJkbWEwb2t5SG5jNDE3ZWpxQ3owNExyK1p5NExhV0dP?=
 =?utf-8?B?d1V0eXFWL3k0d3AxVjRoaWRhZUpSVkVaYUNzeTRwTFJPNGV1Umsyb0ljSDIv?=
 =?utf-8?B?QXZKdUg0eFNQaWZKNnpXNTZQRmxENGhjdWxjQUJnSWpMTWQ1VEhSSGxhRmFT?=
 =?utf-8?B?S1dmSnJabFhSWUhreFJZNGhLTXordFcvVVBub09ZRVJmZWVRNWJPVCsrL0JU?=
 =?utf-8?B?c2tsMzllaTRIdW5hOHl5QXZseDdjbFkvTFZROGJVTjJrTWtJUXBWYVcrTjRS?=
 =?utf-8?B?SWE1TWUwejhoVWdGQmcvalRYcEh3NWZ4eUJudlFJWTltTW9yT1E5Q2pCdVI0?=
 =?utf-8?B?THBwSnlvWjdRdTJGS2pwMVh0RjFBWWRUTWpuWGhOQldZNi9QSDdCU2ozRUJE?=
 =?utf-8?B?VWp5dTFodnUvM3MwdUR1ZS93TTk2Yk9XNkJGUnN6ek5vZ1dVTDNhcUgrcWRS?=
 =?utf-8?Q?h0yE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58129ecf-a202-4ad2-15c7-08ddefb029d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:50:05.2850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: czR2UcJGtCO6AV4qZEFGvvaR7EWqBdD2Jss3xGrqN5w9TaUa2pz14DZ73cYlAaLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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


On 2025-09-08 12:15, James Zhu wrote:
> if destination is on system ram. migrate_vma_pages can fail if a CPU
> thread faults on the same page. However, the page table is locked and
> only one of the new pages will be inserted. The device driver will see
> that the MIGRATE_PFN_MIGRATE bit is cleared if it loses the race.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 83b9d019c885..eb43542896e0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,15 +260,20 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
> +static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate,
> +						bool dst_on_ram)

Use if (!(migrate.flags & MIGRATE_VMA_SELECT_SYSTEM)), don't add extra 
parameter.

Thanks for catching this system memory page leaking corner case.

Regards,

Philip

>   {
>   	unsigned long mpages = 0;
>   	unsigned long i;
>   
>   	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->dst[i] & MIGRATE_PFN_VALID &&
> -			migrate->src[i] & MIGRATE_PFN_MIGRATE)
> +		if (migrate->dst[i] & MIGRATE_PFN_VALID) {
> +			if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
>   				mpages++;
> +			} else if (dst_on_ram) {
> +				svm_migrate_put_sys_page(migrate->dst[i]);
> +				migrate->dst[i] = 0;
> +			}
>   		}
>   	}
>   	return mpages;
> @@ -448,7 +453,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = svm_migrate_successful_pages(&migrate);
> +	mpages = svm_migrate_successful_pages(&migrate, false);
>   	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
>   
> @@ -748,7 +753,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	mpages = svm_migrate_successful_pages(&migrate);
> +	mpages = svm_migrate_successful_pages(&migrate, true);
>   	pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   		mpages, cpages, migrate.npages);
>   
