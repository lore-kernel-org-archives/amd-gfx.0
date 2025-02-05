Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3AAC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F420510E386;
	Wed,  5 Feb 2025 15:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5lRx2JR7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD52710E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:42:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZLEuYN7EG00uD1O9boymUOhW4CpdsNh4aFm1Dy6lt9COSojpIDzFjkFlFir8mzczsDw9rvcKDpDmNsePIi0bWKKxkuc0BTTySbljmp/xeomwnTJXu/mYo7fwejE+RwH2UJhcztJOjaNRkiuDTuGW4GNPEjCdgdQG4joY1Y/cfbYi1QeI1cyeEIVOAE4TZSTxvwQa5dY/ExW+gkI6w9Mu+pq9leSln6zReO6eXIyuCggihGlh+95kF5yLAUnxEsFRuxX7aUouZWST5HOQDyA/e8Nsfqm3gTVdT2YrU14PNAik0cTzqzP4s29fMjFg7eZY6oF7Ue02eZJh3LfQLkc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IstRpB1AKSg+ZjNePUS7QUFshCUWARfnot2gGXaTCE=;
 b=cuDNxcnab3u0xh4/ypQLkzCwTuPyTMtUQDC3vCpp3WSMdUI3KfQ/yV8D9vCliljP5BueE5bTxb2g52+P+oWosS3qIyYcBcieWsW+niN548gG1LOmZAQIdZNsbaW1GeZUVYF257uN1Gt+Er5SiLampa0+UXGj58aJZlUUYw2Ixd+WXWCW9rkldCLzmq1CV4WVT8o6O06ZU8zarX6MAf1TgKqdfeBKDFnZobOY79lZwaD/g5i9ZZTi9DPLnS5Y2LMdM4g2OcUL3Z2TlqcLUa+BborljFkFObD3kwq5vLvpBgHKbwCMDg/KDhFVOChCwlzLkH/bVLAgLTZk6SMtcytC1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IstRpB1AKSg+ZjNePUS7QUFshCUWARfnot2gGXaTCE=;
 b=5lRx2JR75iVDsIN/mk1NgKFmup+R/c6yHeShj/sjymy65M4Wki9xuoBvGo9HViGreRz1BdA390zWjVUqH0K2IJS4+7eIP60Pkybt4V+L4I4OsuYQVyuddIe3+1hmon658ZbcVgc4CmUHUym0rCth/WlffSqpAh2dWiqSE3Gcjfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 15:42:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 15:42:11 +0000
Message-ID: <44edde63-7181-44fb-a4f7-94e50514f539@amd.com>
Date: Wed, 5 Feb 2025 16:42:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: fca467b6-b200-4c1e-0e10-08dd45fba7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDI5NkhhRDlyK3g2L0NDRXZNZE9yYlRZUElQRHlHS3BrRlBtVm1jcTB3L3JY?=
 =?utf-8?B?TUpEYUdUR09sM0ZCS2NXd0dYMk9PTU9jN2ZpTzVadmpuUWhTczRvVmpWcXJP?=
 =?utf-8?B?ZXF3NlRlbjVMaU1pMWZobm4yZklFSWpoS3BJN3V1T2JhTmVYWC9kV2kwMENV?=
 =?utf-8?B?RXlTZjN4VUI0bGw4QmlGQWJ4elR4bCtkc0lMRGs2dElvdjJLK09BZXFlWkVB?=
 =?utf-8?B?bWUyRk1wQWd0NnN4czlOa1ZzV0p5YlRJWkVSdGd0VVpxbHZrQURPQU1EdDZs?=
 =?utf-8?B?TUxMZHFPVGI3SWtuenJzUUN1Qlc0NE1jSldUL2tQU3pkM0k0S1p4Y09qWWlN?=
 =?utf-8?B?eUpwczgwWVJ2cWJJRzg2Q0JnbGJTUFB4Y0QyVTJPT2lTMHNQdE9HVWlvSmRn?=
 =?utf-8?B?NmhQaDN1cFRaOTFTdGIyc01jUUNkaUFPekl0OUtrWmhjZ3BCVUlzRVE2M2Nt?=
 =?utf-8?B?dlNyWjV6SGY4dFI5R3ZuSGhBVGJHMTdqQmZSSEtKWjg4cDJ1MTNKV0NkdHp1?=
 =?utf-8?B?WW9DQi94M251NzlYOE4rN0JhQVo5anEzdGVLejBRUDI2UVZaNGhFMkVGeXpQ?=
 =?utf-8?B?bWc0ZiszYkx0TlkzZ1ROdWc0LzRQQ2c0M1BzUGNqM24xeDJjdjJzazRzVnVD?=
 =?utf-8?B?S1phanF1VmpBQkVRMEJWMTRaRlhqTGxWWVZxUDFQQmppZGl6c21KbFZaNEdI?=
 =?utf-8?B?cmtKZm9XODI5cFR4bWxGTUlEd0NPMDV4Vks1aHo5LzNOdkN2SmhIWjJFUzVu?=
 =?utf-8?B?RU5FVHBLR2RBSlN0TXlYTlVJenF1YVBkZW01MnFSeENORlZQMkdZRnhKU1dT?=
 =?utf-8?B?RXFtZ0xtYm8vTTR3cnV0OWdaeHNDa1BpL3cyV2tzU2x6bm1OVkVDOUlmNVR4?=
 =?utf-8?B?TE1FYnhlaVJtVk44VTdoaXRLVjdTMFUvMU51YS9hUHJjcmlsTUFiQzZIbWds?=
 =?utf-8?B?anpEbFp5YUIrYmZhNXNhYjRWSjhzZ1NTNmI0ZUtMK0dHcmw3c2p5T1R4djZY?=
 =?utf-8?B?TFM4Zk5NQVFTWEg0c0R0WHBncVVOR2VHM2RvM2NaZE4zQkJXM0xSajFlS28w?=
 =?utf-8?B?bHRsVzB4OTM1eEdNR3VyVFF4YStPK0pQMkt5clVvOTZlMVJLSWsvZjBiNW1J?=
 =?utf-8?B?NktGZWxqdFlHbnFmZzB3bHdYNGVrM1ZoMGl4dUZOdGZtZ0Z1THRVUlRjNDd5?=
 =?utf-8?B?YkRHNEo4RTZudTJNU0xpbWNUOExKMnp5NnV5Q1RZNWpyZWtNQ29NV1pRZHh1?=
 =?utf-8?B?cS8rejRaU09MMFBZb05xeWZwNUNvZDdpVzJoWWd4Qm9aaFBTbTZNY25sVlJI?=
 =?utf-8?B?TUQwSGpSaW9uamRENEEzRTJrcC90V3A0akpvSTFBVHB6K0M2aDMwT2t3L2lk?=
 =?utf-8?B?N2M3TEc1L0xjWW9KYUFIN2w1dWFlZFcyZFdrVnVaL21EQkNHOFE3VlpLRGR5?=
 =?utf-8?B?NVNsQW9PUE05UXZBWVlGWlZ0QXlLN05tNGdDcUtqK2M2ZFRlZE9RMkd6Z1Ni?=
 =?utf-8?B?M0RoU0JPaXlXdG5SS0p5RlVBcmJwQnZWVTlDeTBYUUxWYUVWWkJsZjhhT2xu?=
 =?utf-8?B?UnpOMGM2VVpyNkE5eXJSWU5DVlNIcDlDaVl6QlUxU0Vsb0hNVmFZSVBkcy9Z?=
 =?utf-8?B?WFNIVU92VlFQdW5WTk5uQ1RZb2NaQjYwdk9nbmdLRWs2Y1pteWZUTHhUWGFG?=
 =?utf-8?B?bXBPY0pqbXFCWEtzM0QrTnh3R0FiRnVGWW5seWhDZjQxQXYydVlwZHpkVzlJ?=
 =?utf-8?B?UG1tQW1zOFBDRlFDaGw0SW8ydkZ0TXlVdlRhOHFsVU1wWWFZSVE5SlM0VnRK?=
 =?utf-8?B?VWZlcFR5TVd1UDU4NFpYc3ErOWZZcTBrajdsdTBMZEQ1VVVyQ0Y1dE1RMS9u?=
 =?utf-8?Q?ZONxOeCreCkPD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHByUGdnbGNadUNPQ3RpMmhsaThoNFBGcmxoSVZaUWdJc3pFa0YvZ0pOQ3JE?=
 =?utf-8?B?a3N4MG9BUVFGVHJtYmI5T2NhSzhLN0Rhd1MyNEZYK2F1MWozOTdMbDltVXlV?=
 =?utf-8?B?V1NqZ1V6eGRGcXlDb2NOekJuaGdxQTUzdHNCM3pwalAzYWJUNEh5MmhhNDJk?=
 =?utf-8?B?N0pjUUd0dW96RWJHVlQzVFNLUVJiRVFuUytMaDJMcUlvampsY2tkTmZQQ25o?=
 =?utf-8?B?UGxRS1NuMWYzb3RwTkMwdktHKzBaSDZaRlBpNmQ3MUlXa2FEdjQrWUk4bWsy?=
 =?utf-8?B?eVMxbDRKemZGOTlVN3cvRGp4NHJ2S3dLdzVQRTJRM3NjclkwazVsS0VFKzN4?=
 =?utf-8?B?ZmcrRkJTSGl5VEZqNzAydU9INU5ZUWJyTmloaFI3eUJLK0pIWjlUdVIxT2VX?=
 =?utf-8?B?YlRiRmRvWmE1V0Q1bU5TRUNTeUlmYzgydTVHRW54L1BPYUJzQk1BZTZNWVM0?=
 =?utf-8?B?VjJvYWlSQzhveXc3T1ZicUdtTUhNTWVOODJVY09rWDdrZlB5bE43alhQN09Z?=
 =?utf-8?B?QzAvMUljeW0xc01jem9UVCtyNTBsNmF2c0NmYktLTkhZNllNTTM4UEdRNVJv?=
 =?utf-8?B?U0VwVjNqZWw5cDhvQzROSEpWYVRFYkJRVjFOMHh5WlRDMVRaOHNuMjBQcUdF?=
 =?utf-8?B?T20zY2JWcVV3STMvMWltdVZlYXlpajBMNm41OFVkd0F1Nk0wYWZXdjdIMHY4?=
 =?utf-8?B?OVBWQ2hNM1pTeUZzckZaZEQxcTJhRmdHUC8wVjB1OUxlUXRtSUo4VUJHWnlr?=
 =?utf-8?B?ZzJFSjM4MDNlcXlFOVpqb2dRalBpVkhacnNTbGhkcWZaakh0WHVvUUVKdUhn?=
 =?utf-8?B?WXBGcFZHTFpZdnVnQkNuNWptQXBqdjc3aXJUK2tIOXYyQXVsZ09qS1NRZUNK?=
 =?utf-8?B?L1ZyaEdsd3Iya09xK0QvNTZDQSsvdGtuR1NyWEovNzJZVDZpRlN3NGs2UWNF?=
 =?utf-8?B?eVZlUmRERTF1NXdKdDFvVEJDNkk4R29nWUc5bS8xTnBzL2FCYlhuS21Ud2hY?=
 =?utf-8?B?WUp1TUF5OGpDeGU2TGppT0MyWldBS3ZFZXh1MS90ZzRZYTlJRVg2eEV6VjVX?=
 =?utf-8?B?YUxncHZuTE44TDdFU0toTCt2Wit6NEk5WHp3UEd2SmVNcjRjck5oVFpYZk5B?=
 =?utf-8?B?Nm5WNVpTN2RhKytFMVdhdWs2TlpLdUhSNVQvTDR0NFpObkUwYzZ4bHptUUsy?=
 =?utf-8?B?cUI1QVJ1VzRkbnl5NDk4aFQrMUQzUUFRWk5JK1AvanVNL3NaVnNoQnlVWDdk?=
 =?utf-8?B?ZlEvMjJSQ2xiU202UzFhUXlHam5rMFdBNTlkcGJvWU1UQ0J6amdwR3h4Mjl6?=
 =?utf-8?B?aDBNWTQ5NE5wdjU4TWFIUi9MWjFyMWJ1VjlSYmUxbGNuU1dUbGFFcmtxZmRo?=
 =?utf-8?B?eXJTTXBSRk1OclFFK1ArVnQvM0R6MkZsa0VyeDRyOWVrTkNUdTB1TnloZU5I?=
 =?utf-8?B?M2Y2N0JYbnRTYk54QS9qTDgrNk1qVlJTR0ptYXdsL2VNVWlCc3daS25LZzFw?=
 =?utf-8?B?S282b3NVSzA2SU43czBqN0RrTU5EVTZpQXNUdFgwRWJLVS81TFloMlJDSDBL?=
 =?utf-8?B?U3VwRzRqckVnemR6Njk4SldRa0E3cGhSemZNUjduQ2pRQmI5cXFrS2g2ekxH?=
 =?utf-8?B?WExBRDdLdHJOSjcwdlV6OFVYV3BReFBOTzFucnkySDY4OGl2OFl5ZlU0dWtp?=
 =?utf-8?B?bXBJeDNtSG1lalRzZ0xpeENPN0VRL3FSb3ZERjdXYUhlVHpNdmo4SnFJbW1Q?=
 =?utf-8?B?T2srcCtsRnZLZGVSbmpnZXRrcU00b2ZEMGR2UndQeWJ5MndPQXVWUVkrUjUr?=
 =?utf-8?B?NVE3THA0OCs0WER4ZzljamxWbzdYWGY3OVhvR2lZVkhzRXJDeWJKNTl6VVpl?=
 =?utf-8?B?alF2ZEV1MzZFOVA3bmxHYmMzRk5ZTmdIWU1BR0Njd0I2VXk2VlJ0dk9FVC9z?=
 =?utf-8?B?d3RiOGlWSUM5ZnhYRml0ZE9YYTFCZXhFVmlYc2xHS3loNEpWQThpQjl5bHJy?=
 =?utf-8?B?eU1uZVNyUXdkVTNjT3k5TTlKRzcyMUZDSzZCd1h0OE83N3B3bndnT1paUjVW?=
 =?utf-8?B?MjdESUc2cHNkSldrNG5nSzBuUFcrKzZyREFWdExKcVdITWZwRnJRd2ZSR2dj?=
 =?utf-8?Q?5Q1oZkhldPsmOq8DI5MtyBfd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca467b6-b200-4c1e-0e10-08dd45fba7fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:42:11.5211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzzIaY5XoQEeG8TWDBmYaIeIqMj9DaDxWmxe26uuaTZZ/cDeBAkzahLOUEl1yeTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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

Adding Hawking for commenting on RAS.

Am 05.02.25 um 16:33 schrieb Tvrtko Ursulin:
> The helper copies code from the existing amdgpu_job_stop_all_jobs_on_sched
> with the purpose of reducing the amount of driver code which directly
> touch scheduler internals.
>
> If or when amdgpu manages to change the approach for handling the
> permanently wedged state this helper can be removed.

When RAS indicates a problem and reset is disabled we shouldn't mess 
with the scheduler internals, but rather mark the device as unplugged 
and clear the PCIe DMA bits.

In other words enter the wedged state which is now well documented.

This way all submissions will run into ENODEV errors and be cleaned up 
immediately on submission by the scheduler. Applications will then just 
wait for their existing submissions and get an error if they try to send 
new ones.

Stopping the scheduler and then messing with the internals is basically 
just a really ugly hack. and never made sense in the first place as far 
as I can see.

See below for more comments.

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 44 ++++++++++++++++++++++++++
>   include/drm/gpu_scheduler.h            |  1 +
>   2 files changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index a48be16ab84f..0363655db22d 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -703,6 +703,50 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
>   }
>   EXPORT_SYMBOL(drm_sched_start);
>   
> +/**
> + * drm_sched_cancel_all_jobs - Cancel all queued and scheduled jobs
> + *
> + * @sched: scheduler instance
> + * @errno: error value to set on signaled fences
> + *
> + * Signal all queued and scheduled jobs and set them to error state.
> + *
> + * Scheduler must be stopped before calling this.
> + */
> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int errno)
> +{
> +	struct drm_sched_entity *entity;
> +	struct drm_sched_fence *s_fence;
> +	struct drm_sched_job *job;
> +	enum drm_sched_priority p;
> +
> +	drm_WARN_ON_ONCE(sched, !sched->pause_submit);
> +
> +	/* Signal all jobs not yet scheduled */
> +	for (p = DRM_SCHED_PRIORITY_KERNEL; p < sched->num_rqs; p++) {
> +		struct drm_sched_rq *rq = sched->sched_rq[p];
> +
> +		spin_lock(&rq->lock);
> +		list_for_each_entry(entity, &rq->entities, list) {
> +			while ((job = to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
> +				s_fence = job->s_fence;
> +				dma_fence_signal(&s_fence->scheduled);
> +				dma_fence_set_error(&s_fence->finished, errno);
> +				dma_fence_signal(&s_fence->finished);
> +			}
> +		}
> +		spin_unlock(&rq->lock);
> +	}
> +
> +	/* Signal all jobs already scheduled to HW */
> +	list_for_each_entry(job, &sched->pending_list, list) {
> +		s_fence = job->s_fence;
> +		dma_fence_set_error(&s_fence->finished, errno);
> +		dma_fence_signal(&s_fence->finished);
> +	}

This is in the wrong order, e.g. already scheduled jobs need to signal 
first and then not yet scheduled ones. Otherwise you violate the 
dma_fence ordering rules.

Additional to that this is racy like hell, e.g. even when we had an RAS 
error it is perfectly possible that submissions finish normally.

Regards,
Christian.

> +}
> +EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
> +
>   /**
>    * drm_sched_resubmit_jobs - Deprecated, don't use in new code!
>    *
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index a0ff08123f07..298513f8c327 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched);
>   void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad);
>   void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int errno);
>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
>   void drm_sched_increase_karma(struct drm_sched_job *bad);
>   void drm_sched_reset_karma(struct drm_sched_job *bad);

