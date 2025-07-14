Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DA9C83F1D
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 03:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E645A10E1D5;
	Mon, 14 Jul 2025 03:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p45dkhX3";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A190810E1D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 03:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThvOHDoc4L1AYR0IXcDrgmdlMs6G2Gnw6eToytyioE/4KASu150HuDEDBXJgnEb8JTXbKv9jThLS/bQUKAtr6Bfe34R2jqUjBRSR2/muDZchRzCAZJ8/Q8O7bGQ0rkXsuUQELMuJ1e0GzNC5aZcr96poftuQUNUYRXoL1x7dlVGHC2K2ployopNC83A1w6e1mkQYWKaR/ch6ewqp9qgXKOLSLcosgJcsxRXB2EJurUe8SMsQGnux2uVfwcLgyM0IuvFppDaS+e9rrKzz2juFhHdQ7bCEmmCNY5s4nTvC4eCyzFFmI1R6tqwSM/o0C+7Vz2tE2UJwdwS2gGAckjLxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOF4snzUpVqqf51zaUxoMtg/zFu51YUBe9LWpY2a3UA=;
 b=F9TEu9JX4Y/ky4m9jox6ex+qZV8eccRnhRuwYRIiryn6+f3e6iUwfi/enM2iPJHsR1KV1RoM0TcnzzWV7qg4iz269GZVwq95V7Q2hw7Cafk9DjhMZia0lMo40+4ioRrJC1VcBSQgYo1WYoRXK1tzY5mNIxPe/HTXTpSo6Er47fCg87wkc3Z3xy7IVUXnXwRePQlymV4mHbqYcSbPRFJLdIubIzuOLG+h7D9UerlDzDCFBzsh9bLCFu7W/SExGwJHPizIygfPliqRxwFzmf34KEmV5QODF5FtapoSbcapRlseID+o6YTrY8H/AuzSykpfgekm4RHXXs7VW8EQSZLwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOF4snzUpVqqf51zaUxoMtg/zFu51YUBe9LWpY2a3UA=;
 b=p45dkhX36w+sRqxFEMMC1/pMGPObtfrUkMMQPDSa8n63Jp/L/LdcsFQoPrdjxO5mE1wzLFHJr3XHOgN1mIXVbBbZAYV0Mm4lB72W7eHyM3EX8d0rDCoGCtIOyi3F2hbANM3LenWUkvjbPVsdAq3xf0/ZwDwll+KcAF8Kxsc1diQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 03:00:52 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 03:00:52 +0000
Message-ID: <375a4679-77af-db5d-ed4a-e3273717b3dd@amd.com>
Date: Mon, 14 Jul 2025 08:30:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/33] drm/amdgpu/jpeg3: add additional ring reset error
 checking
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-4-alexander.deucher@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250711224024.410506-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 990d49ef-1a75-4784-3aba-08ddc282a4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlBkNWVxMDNtb094OUkxd2Z6N0Z1a0tRbGtLOVdYVEN3Q2NGNTVyV0h2MGw4?=
 =?utf-8?B?TFZqZHF1YWJweEdVSkhSdjAzZmVSQ01oc2xKVXg0cWdwTDRKNGRZczFGRU51?=
 =?utf-8?B?ck1IcDF3M2FZRmpVVlJCd2dzNk1qY1hvb1pFYWpiL0x5cXNwanI2M3duU0dX?=
 =?utf-8?B?OUh1VnY3bUpwV0cydjBHa1dHMmFsTDFRKzZ5aWZlTU5hZ2luSERTdEdnVzVO?=
 =?utf-8?B?K0I4eENkK2pTRzk2cUlIZkVWZ1psVjM1RUNpWWJpby91NUJYUWJMV2JORytT?=
 =?utf-8?B?eXJDZTJkZE9VMCtwQllQMTRqaU9JVkh1bEN4Z0dWRU1EM3V5OXAzUlU3Mzgx?=
 =?utf-8?B?TURKSHNBVEtLYWM1STZJSU9hcmhWcUl4L0s2eCs3aTdleXA5VkVmMEdSQUlZ?=
 =?utf-8?B?QWRLa0ZiZXovNTVwcGFFcjJHc0MraDlpK3ovYUY3ZncrQ21IOVBGLzdiaDhW?=
 =?utf-8?B?SFdOOFRWdG1YWjk5NlByK3NmWUNHcVV0bFVEY09WNG0xRUIwZ2NFeHRaeEFo?=
 =?utf-8?B?eW03SG9GaWJqM1ZLRGo5VGprTlZENTU2Y1VrWjdveVd5Y2JqeU9hMnpLc2VU?=
 =?utf-8?B?OGxCM1dNM2p6azNpRFlFZHNQWXNDNXBxL1drYmh4YkxKeVFneU15QTc3b2ty?=
 =?utf-8?B?bzh0Ym54ZjhMaFdHWlB3V2J3aS9CNGJxeDc4Tkt0a29QTXJCVEVVYnFwWjdX?=
 =?utf-8?B?OTlmZUFMbnpaMElXNXBCaGVrM0V3T25rRVBWeGVEZ3lHWXh4UERjOHNrVGRU?=
 =?utf-8?B?YXN3Z1Uzd2JZL05mUElta0tuemZlc05TMFNSb2JyMGtxRzB5WS9tNnRXbnM1?=
 =?utf-8?B?MHdtVHVNOUZjaGZBMXZZM3E0UnRNR2JQM2JDd3Z6NTJGN3FaWW1EVllvTVFD?=
 =?utf-8?B?bHdNcU1XNDJEL2NZWEFnWTF0VDBVMUZTWDBpNmZzNjFiYzMySFc3TnB0dVdS?=
 =?utf-8?B?QmZWUkZqbHlnWkltYlhxbUl1L2Q1REVWZGViNmVPS2pDU2VBb1c0QmR6SWdU?=
 =?utf-8?B?dWZ2VjZNcmtmczhDSVFxMWd6U0VrYitGK0dZSHdxU0dCRFVtczQrNERmQWNE?=
 =?utf-8?B?d3pPWG9rNUJoM09TRFpHSERiblZMWkNndkZ2eUl3UDNxQUQvKzQ3OGVQQjRL?=
 =?utf-8?B?bDBnbnJMcWtlYTJVLzF1cTllQ2RtbW1kMVFSaUVFYkQyRXB4U0VHNmZSMmM5?=
 =?utf-8?B?WGJqb09SM05uQzZUWmxLdWJnc3lCcGlQVmdySU5UN1FkbnlqZXAwNisxT09v?=
 =?utf-8?B?WUp1NjYrSUd1dmFCRWM3dkpaOXVZN2pDTGo4NUROQzhrNU01cTBheXVNdlR0?=
 =?utf-8?B?ZDBHTEhTT0htbFYrTmQvbHg2a09uNVRkMUpyVkZEK3FFWHRnYi9uOXRoWGdu?=
 =?utf-8?B?b3lzM20vNUNsU1AzMmFQaUQwS1I1dnBzaCtCZFMwRnN2YWJ5eFNiT1NtQ1BU?=
 =?utf-8?B?MVpVL3Vlem5EWVh3T2xZQzdyZVQ1bnZrNmFLSG9jYTh0RVVkL3hqNTB4S28v?=
 =?utf-8?B?eE9OLytnTjNEeUJkdDlkL0FMaXM3QklCaWV4eXViWWNIYUFxYW02RlhpUDBQ?=
 =?utf-8?B?MlluZjV3dzAzS1FVODZtaDB0cGRmU0ZxZWNUYkxCYW5RRDEzelZJK3Z5L2Jq?=
 =?utf-8?B?MVBkNUZLY3JVWmk3K2lFSHhaWVU2S0E4bFU4cGtoOGZFeDNuLzE2U3Rtb2Mx?=
 =?utf-8?B?Qnk4cUYvdTFNZEVLWG55T0JzN1UyaFlpZndJcmNPZURwbU5VTUhpRWV6T05F?=
 =?utf-8?B?c09uRkIwWGlMZFNUd0t0dVFFRklaYlN2TDRDeFpxQkkvQXc5MCtEWVRvZlY1?=
 =?utf-8?B?QksvWEZVOUNWcjNGUUNlRFhaTnByTXVaYlFPcDZ1eDllS1ZPTFVLaCtXZytN?=
 =?utf-8?B?MytjOGcwLzV0dVJsbVo3RGszbVN6dG1aY3dsL2FSTlptMnBqSXpDUGtPU0I0?=
 =?utf-8?Q?cRBLb7WcD6g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhWakNFMGlCYmk4UE0xYTlVNVpoemUwZElwNEE1a3EzMUpocElIeGE2eG56?=
 =?utf-8?B?MmlSaStlNmxtQnBrRVdHRTJRSUl6RnpySmxuS1dBeGNMOEFuUzh3SnpKTGF0?=
 =?utf-8?B?YTdidWNSQ3FiTFV0NlRqN0I3SlA4K09yek5VRnRwTXhaSHRWdjFyY2RrZ1hz?=
 =?utf-8?B?R0c5YWd0cFhwRFVvaDUrNkVxbHA3VDlESGVRYTI3SFlxL3E4d2YzWDdscC9p?=
 =?utf-8?B?Mlc2eCtkeXV6WmM1ZzdnWlptazFLOENpbUpSYjMvK08weGlGY2prQWRjMmNU?=
 =?utf-8?B?cklpbmNwRzJoemdvMDdBZzJYQlNNbjZHc2dBRkhpTlJpVnN3YnNtWE8wdHJE?=
 =?utf-8?B?dS9lNmxubDllVzJ6bk1CbEtRTHp4MzRrbklnMTRGZ2daelNtMXV1dFVvT0ll?=
 =?utf-8?B?QnBrU1lCU1E3Q3Y5bXFqQUx2VnpCdWN3TkVERExlbkNlbkREUVUyMW9CVXJH?=
 =?utf-8?B?dEZRUS9JaHgxTDAvVE1qMDEyMVYxa1pSME5ENHhaV21LbmVBeE9yK0JZOFF0?=
 =?utf-8?B?UnJYdzB5Q3d5UEFsOXkrL3VrWlgxOGp3M3k1eWJGVzdKb1E3SDNyNDg5WDY4?=
 =?utf-8?B?YlFDRUFjMEswY2d0SE9rY29OczdBeXBxZTF5eXlJazlZR1pid3J1Nlh3NWtN?=
 =?utf-8?B?bGRwVyswWVFaTjB6akpScFp5b0dMRENBSVEyNVBFRWhXTHdvODdJQnVlVjBK?=
 =?utf-8?B?WjFjK0hoeTVCZzE2V04rV3I5ZzcvbDFYZmM3Z0JCZ2ZoQUZxZlhXWVhGRGVy?=
 =?utf-8?B?UVJHRC8vYlN2eFpycmo3bnJGL3hLSG1oL0xoeEMrRWZxVXlYOEFBZDJCRk1W?=
 =?utf-8?B?UzRzWnlUQi81WDQwTk92VEoxLzMyRnFQK2ZlSTVFSmU4S3dBOVg0U2NTdWpy?=
 =?utf-8?B?K3YxcHJETnMrbUZpUkZBVHUwbzRuM3ZoWGE5am5QMThpN3RKdkxzRFZ5YVRy?=
 =?utf-8?B?cmw4TjZmeDhaeDdRdS9taTMzNURyTmVtU3VqSzJGQys4OXhPb0FEMytJSERs?=
 =?utf-8?B?RHJRL0ZtejAvSGpHRWtUYUVmVE0xL2cySEllMTF6bXN1dXg2ZFdvUXdRWS9R?=
 =?utf-8?B?bzhBcGZTTlFOSzl2clNZZTdyME9FYTFHM1JCQ01nL05rTURwODVjQnNQcHMw?=
 =?utf-8?B?Y3AyeEtJdFlsdjAza3BLbXQ2c0ZtWXEvMXkxbUUzcE1wdWJPbUFPa0J3S3JJ?=
 =?utf-8?B?bklHcFpjdityWVRQM2VzaFRISG9STnQ0eVJzbE4wMENGODRlUzZMVmZ6WUhV?=
 =?utf-8?B?LzNqWnRrVkxCbTI3czdGNzJYWjBNKzRSMUszNHRWRENoM0xMMGZhN0p4MlFJ?=
 =?utf-8?B?ZjRCK1A0U0lobVh2SThhdW0zS1AzcCtIK1ErRWV6QWhDZWpBQmZJZUZVK0Jp?=
 =?utf-8?B?RzdLUzdTeitXdHM5dnhLbitaUmRvd0Q5bmlUaUlXRTlicnhJcGNDT3Rpcm9O?=
 =?utf-8?B?MmlEaWxYdkE1eThxSXB2Uk0vQ2ZMd0hsVFQxSTZFcE9XazhFU2ZBZFpsaGUw?=
 =?utf-8?B?UFdDY0pNV3pPR21uc2pVVWhwaU1yZTJmSjRucFV2U3hHc0pTUVg3Q2FLMDFN?=
 =?utf-8?B?MHd3YmZNZ3htdWJMeGJTOFJ4OVZSZ3JUOWR5ZzFoMkZsTGF4VDljUklLS09x?=
 =?utf-8?B?UGRJVllObUM3L29Zcjh1SG5PbEl0a0lJUWM5M1FiOGRmckVpNjV5SmM3bWln?=
 =?utf-8?B?R0VZU0JNMGloUUczT3o2d20xa2FPd1FIaXhWQzJ4N09XUFl0Y3VjN0k0ejla?=
 =?utf-8?B?b1ZYQWFLeXAreEpVZDlHOHdZNFRxdjJNVXpMaUdwOVVaTHFtdVdtVldXZm5R?=
 =?utf-8?B?ZmpJN01nVC9MczNuREN6UjZBM004VTZTUlQzNXI0RW9iRUJRallNcUxHZHpU?=
 =?utf-8?B?K3N1RGpTOEVqbVYvRnRNVHVQTEYxVENrTFVPUkxnZCtmR1R5NUhWYmRGRUtl?=
 =?utf-8?B?dHJmMlJPVDgvT1psaVlDUk9CV3RYUHFnTllFR1BqempGTm5nRkdjUkJmY09Z?=
 =?utf-8?B?RnBqVmRVRkYxSDQ3Z3Q4VlpldmNCQWVnZzVyc1FLUHdBdlpadHlTNkhGblFF?=
 =?utf-8?B?R283aGlGQzlKb0IrUFNCNktqdkNwdlBDdkJWWUcrTGdhSms2RHZ2VS9mZldu?=
 =?utf-8?Q?YFFYn3RmEMICIxxk2RM2QkRt5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990d49ef-1a75-4784-3aba-08ddc282a4b0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 03:00:52.5292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyfqZaUKelAUq7cFCU1d6KOX2jUbH5qLl4MFvyiCZvbRdHSFqeD0mJ+wcjV2xrAKlb9f3A2okrNvZtETgtdvpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134
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


This patch is :-
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

On 7/12/2025 4:09 AM, Alex Deucher wrote:
> Start and stop can fail, so add checks.
>
> Fixes: 03399d0bff25 ("drm/amdgpu: Add ring reset callback for JPEG3_0_0")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index a24bd833d6442..5428930eafa3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -562,8 +562,12 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>   	int r;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
> -	jpeg_v3_0_stop(ring->adev);
> -	jpeg_v3_0_start(ring->adev);
> +	r = jpeg_v3_0_stop(ring->adev);
> +	if (r)
> +		return r;
> +	r = jpeg_v3_0_start(ring->adev);
> +	if (r)
> +		return r;
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
>   		return r;
