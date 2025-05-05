Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE2CC3ABBC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 17:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC5810E43A;
	Mon,  5 May 2025 17:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1h1ggSc4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6BA10E439
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 17:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aP1R1OmFeZCi4CsQY7V8lRCf9YCQSDOjbQsAnZgYQriVwhZvQPGlbL8HEyJ9ac3YZ/W36s8JoYq6EhtLc51qHiY6UKI5mRGvJNGMbaD3ao3gDSAAiZpn6hZJy8abh/bMKbJRi3JBkb+om4iqMy4UH76RQqvBCSUg/Sc6ygjYF3Jb94okWJeA0Pt6KD6GeSNNH77beoQV/ZrZpY28zQ5qveSQF6A+n4KTq7Zt7OjQOOBuAu1hIOiGMwpUH1fNMu1nR0aNP5QxsVr8ipLA57mYlMKCp4q7T1yTN+blDUXDieAukyNhSCfDcTxysE2fAqX2/KnCRvVnqIzo1qbZM8ZFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC6PPjwfNlLloKMfQtzdlIDFcLcxRUgANX3nsQ2coho=;
 b=zEkH1aMAfwaypstgv15UObIcfzgB3JEOplazDDH2bjJs85LeC+7JB0wLE7+0PzDXYpSIIPm239Tzz6DTidabvG1vl3Skn8c5XEtrLKQUQrbgaZKsJPusTQhyFlXrC6JxPkWfigWmPu7oG1NrJ0Mnl2CvVdHRQZ4LpoCdw3AJLGXFR8WpZXZ/wFORswU6ksuRuuTFtC2F9s8zNcQICx6Usu41GRasscPBR5wlAyFYaAFursYjfUN8efOhbBb2KuF5fXzd8p2QU9xXzdq+W2f8jr4eDeZOIy5Q0EtOQJhwBjrKVOHgUNTcrvIXvWhIjlvnvoT/rkQdBucwXL+EbNn4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC6PPjwfNlLloKMfQtzdlIDFcLcxRUgANX3nsQ2coho=;
 b=1h1ggSc4q3PHpdYoJ63lnNKjNcs1iEA37R52A4YgyiMPFxXkwgSKs7krgp57SKOwMvBIzk9o5QQhanrqlrDPsG3hhRYPKvtBeKcC2ICei8QFlEygGQBf/Mk2vD8WG1R1ChTNjE22JETdq7Xm5h/5p7v0uIeTizrkO4Q3aK03ayw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 17:37:49 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%5]) with mapi id 15.20.8699.024; Mon, 5 May 2025
 17:37:49 +0000
Message-ID: <720cb274-b482-46a0-be3c-e299c03069af@amd.com>
Date: Mon, 5 May 2025 11:37:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/display: Use optc31_disable_crtc for DCN 31
 and 401
To: Mario Limonciello <mario.limonciello@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250504221154.409695-1-siqueira@igalia.com>
 <20250504221154.409695-3-siqueira@igalia.com>
 <41016b22-d09d-4cdb-abca-a2ab016e47ed@amd.com>
 <3417c8d2-459b-40dd-ad09-5757bb279935@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <3417c8d2-459b-40dd-ad09-5757bb279935@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::23) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6f85b7-a412-49a0-3ac3-08dd8bfb8dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXorNzFJTEdvVllFUnBGeFVzWFlZTUNLRXp1YTBIamRBODFUUXhzaXp3UXFj?=
 =?utf-8?B?c2lJb201ZVFld1JOU3Uxd3NienpPWkRuSG90SXc3MjNUOEIyajIvbERZMEdw?=
 =?utf-8?B?TFBCQnlVYkJHY1JEVnp3TDIxQnJZemdyeEN2eWJVenYvUzhmdlRXblNlZ1di?=
 =?utf-8?B?ZXpJdVF0cTZaYW92d0E1bnlQeENXSWRRSVcvNDhKV3p2a0h1YXplL2ExT2U3?=
 =?utf-8?B?WWxCb3NlN2JhTkV0SzdIdjF3dWVGQ1NXb0Ircm1BQ0tWTlFmRkowNnROQWdt?=
 =?utf-8?B?OURpQjJ0ejNGU2VFcXVVQVFlMDBWTU9SOGFtQ0I2UXRhTy9DUzRJbExLVTM1?=
 =?utf-8?B?MVRLSFRkWkRWT25kVENRNWIvZVdHMUVyV0IvSjVpVVl4Z3V1KzlNREh2ZmVr?=
 =?utf-8?B?ODVNdjdzdU92N2RUdWd3QnNPMDc3eHd5bWEyTzBUUUdvYis1dFJIdGpkeXZP?=
 =?utf-8?B?U1BqL0JrQVVqVFQ5M09CQUlpZDB3cWx4ejlPRit2VUp5NnJsR0ExdXRrS2pu?=
 =?utf-8?B?RzJSOTZxRjQxSzdkeXZPZGp0cWhEcWNNRDQ5Y2JIazRwZk9obFlsMkxvNktj?=
 =?utf-8?B?ZUtNeVdmSjNaVzNLb1dyeEpVdGNPTXVrTGk3S3FBVStLclNJNUJlVlRmMEJL?=
 =?utf-8?B?eXFzWkhvZitnZnp2K0NxcU5oSmNzTW5UY3hQaGgrNUJ3aWcvYTRnZUw5Rmhv?=
 =?utf-8?B?K0V5bzdjYWJQS3E4MEVoQkhlK3l4ZkcrWWFhY1phMi9senNLK3AwRXBaMWNX?=
 =?utf-8?B?cTZKbzRHWjVHLzNTclM5MzFvYko5WjZvZ0NGdFB4N1d2MXBqeEtrZFFTUllL?=
 =?utf-8?B?cEFabHFOanJPcDNMLzdvaWRKR0VrSGN5VmcwWVZXQjNaSEFHRk42amZET0Fn?=
 =?utf-8?B?TEgzR0w2cTA3enVBL05zWjNhTDZvc2RJMlVnVGxKZDZjOHhLT2wzU3pKMC80?=
 =?utf-8?B?Rk5Ib2dFQi83RUQrTC82eWRSek1EeEkxZStTd2xUVEo4UVBrN3hOSEUzZGE2?=
 =?utf-8?B?N2xPZzhFTXhNRHdVd3FoMTRUejJVQnRWWkI5S0o0U0hGVmdQaXBUZ0xnM3h4?=
 =?utf-8?B?SndaRVdFeTdqdHdRZVNFU0crWXkwK21BLzFhQWRxVjlVZEhEYkFoWm5zR2Mz?=
 =?utf-8?B?dFN2OEFlbXcvZUpkdjF3bzY4eXFKdXFxenhUSm5vUGFBaU8rRWFzRmd2Tmxo?=
 =?utf-8?B?RXRXYW9PMFFHdXFvbzRncVJVMTlzbDRZUFZCeGtvQlRFUlBxbkQvMFIySXV4?=
 =?utf-8?B?RXBHS1E0bVA3TDlucjdDQmFZN1VLNzh6UFFPZEUzMWRDMEVmOGlkVkE5SVVr?=
 =?utf-8?B?ZGkvc1dNbGRZMncrRkREc1VrbDVRa1B6WWdFejJBSVNkeithaHJKTU1WeHpX?=
 =?utf-8?B?eFhPKzJtazEydEdFQWJCUmt3bCtvYW9qaytxQi9SbmRHb3k4aC9WUERYbEZB?=
 =?utf-8?B?bEl0eS9TaGh4djEvS1dlRTZ2UjhSYmpLZm1QREZoOXUyeFhOQmFIWmJkdXhh?=
 =?utf-8?B?cncrTjRCa0VtVUw2SklGVWFFLzAxSVVybmhHQ0tHeDkybDFqZjUyaXBORHBn?=
 =?utf-8?B?L29DWHN2M1BwZWlzazJLQ0VkV0VzTDNSMTZBd2tyRzd5V0U1NjdOUm55ekpn?=
 =?utf-8?B?bEE3UU1mMzNOM3VPMk9WdmllTitXeEc0c0JTM3ZPdDQzMVNsUFdhMWdDVnNC?=
 =?utf-8?B?RnBObmNIUmZycEh5cjRJclFrVDUwa3dNR1JMeG5wMUtDYnNidHZDMDF1N2c5?=
 =?utf-8?B?c2NqaDVDbUl4aVRsWW5xMHdXd0VEaEZKMGFJNWt3cHVuVlpFaXdERzMyWXA0?=
 =?utf-8?B?M0ZUOWNYUVFZUGRwQjhoeVVvcU50ZzNaZDNhMXIxZ3NnRHRaWGNkWXFKODhk?=
 =?utf-8?B?NEZ0bENsQXUxVXk2L1JoRWU2cDZvYlJ1YTlLM2VVN2hKam1SU2RKaElWeVlp?=
 =?utf-8?Q?Y8THSVPnj6I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJyN1lBSTZkeGhNV0x5SzY4MGhsS2JZN2Z3ZlQyQU15anVrVW1kL0w0U3Zw?=
 =?utf-8?B?VTlZdUZ6VFM5NHo4MWR4RGE5TGxJNys2d3VSMit5UWIyd0J6aWhwN00wZk1N?=
 =?utf-8?B?ZkpxTDNDK29ERDdnSUtPQk1vQ1VCWVNXd2g5VUpTMDR0c3UyandRNm84UHFi?=
 =?utf-8?B?bkI3aFNLZXBUMDMrYUxVTVZEMDlIdXoveVkrYk42SllVNXY2MVJlei9xQlh3?=
 =?utf-8?B?WmdqMmVVV2x4YVRJS3JhL0RRWVZHTzhDenRvUlBjTU1Tb2liTTRuL3RaaWFN?=
 =?utf-8?B?SWR6WWhaK2hQUkx1MXY1bDZCT3dxb2loWlkxYTJGTjlUUmp1cWE2dXV4R2dX?=
 =?utf-8?B?RHdaM1ZFS2RwTDBqNmxkRWxPQWN5cll2V2dxS0lpSWZ3dDZTaW1wTFloVE9k?=
 =?utf-8?B?dVBJNHBxSVZrWGduWU5ucjd5a3laelc2UHN6T21QVjJieDlPejJ6RnpvVkFh?=
 =?utf-8?B?d2g5S0d5UG15SHpFMnRTeDl3OEh5K2p6UHpCdTBNUmduN250eFR5SWFsSWl6?=
 =?utf-8?B?OTl1V1h3dmVsYloyMFloVHdhRldWWDEreUh0d2RNQ2t4YnU4UWhwMXlWOVZN?=
 =?utf-8?B?YXlzUGpDb0xuR21SRU9TaUJzQlpOcEdwd0o2M1lTRjBWNE8wNEFxREdoNHgx?=
 =?utf-8?B?KzlWTEdvNmk3czB5bURndGJZTGNISi95QnNaSk8yNTFPT2hiaWxwZ2RUU3NS?=
 =?utf-8?B?dEtBTXJDWUJIbVAxa2FmYm04WjdLbmhYblN2ZmJtaXU5eTVoaVN3WlQ2R1Nz?=
 =?utf-8?B?Zng5TUx5NzRpNHB4ZHY4TUdVWEFYb2czSDJjN2UzR3FTMFlQQzNtWE55d213?=
 =?utf-8?B?dThRaEc4ZEpiSDA2K1JNMmR6bzZnM2Z0blNrbEFqYlFOQzh5a3FkblQ1b1gy?=
 =?utf-8?B?OThGQmVORXFFZHhwakd4VzZPb0hxd0t4RHQ2VG9xR2UrZGZOV2gxYTE4aXg3?=
 =?utf-8?B?VmNVUlhNczNoVCtxNm03VVZIVFFFQUtFdWNxQkoyKzB5ZHMrZnN2ZUpKajUv?=
 =?utf-8?B?NVFZMm10V1poNzhOUlEzekZmeTk0T0NyQVUwaTR0OXA1THVCd1FMNGlOZEVj?=
 =?utf-8?B?SnBVVGt0aDI1VVNmUVZVRWhRcVY1NmkrMEwxWGNZVXRWbHYzNkU0QUNCa2Ft?=
 =?utf-8?B?MU9wV0xpSmJCb3JlY0R2SThSTEJUUzlnMUVGQzhtc1krcWNTWmtFTTlsUjBQ?=
 =?utf-8?B?aUVscWRuREJPK1Y1V095eWxSR2pHaUNxNkZoWHJnYnJVN1N3dlAxejRSbzRx?=
 =?utf-8?B?a2Y4bE05YW1WZmFvUlk2WG9tcGdYeVFENmNRRHEyblFad05XclhmU0VWejJw?=
 =?utf-8?B?aVZWMnR5bFBPTnB6em14alluS1pLNk5DY1AwUUxuRnZtSk5GaGFhRERhbis5?=
 =?utf-8?B?d3ZGeWN1bmh0Vm1MWFpMY1Y3TExDMnoyVE5VdHpYRnZ0bHJJYzJIU3dNZ3R6?=
 =?utf-8?B?cHpQMVJPU254bklxdEhxc3U0ZGJsMUs1a2o3K0R6bkdEU2lTRm02UjhZZHBP?=
 =?utf-8?B?ZDN2ZERFQUtqMG02Z2dKcGNiTHJwaWVSM1BQTXRLSVplcGRYOWU5ZENnTjhn?=
 =?utf-8?B?QjdKUnBncnhDWkxWaGtuM0hoS0g0ZU5OVjNrODlPem5BcHBSMFBmU1JXMkZT?=
 =?utf-8?B?R1EwMzgrMG54V0hZa2FodXRuUmY2TXJhanhkakZ1azhvR2tkM2M3VUF3Uk9P?=
 =?utf-8?B?NzA2L2F4dkdiWmlqQjROY2NybnZWRXJDOHZVSS9xM2pYcitOeHl1YzkxZ3Ez?=
 =?utf-8?B?RGVWeEVvOU1MMlQrTjJGUkRHYzYzYmVTcjdPdEJwS2JGZUVJWmFzTUxMaVpY?=
 =?utf-8?B?N3BVbk5TZFprMnhwQzZxNzJWWGgzcVo3UkpDaTFyc3VHTlVoNlZhNThtQUtZ?=
 =?utf-8?B?WXk5Tk1KaE0yREloM3RYcFpMa0FNOStOS2htbXBwVFNLaFRrNkdPN0h2RTM2?=
 =?utf-8?B?YlN2MjlnY0lSSzd5L3luSFgxdTdCUnM0WkxIc0hqb3d6c2Jydy9aMHdzaGpU?=
 =?utf-8?B?MWZWMC9aQTBOeGt4c05MK25xM25iQmFvbU5tT0RYbCtDQlZCVU1FVFNJTStF?=
 =?utf-8?B?a3RpSC8xcExlbkxjMFpLZ2RLVWUyd21FZ2hPQ2YzbGR0RVBtcHVKRHBZcUor?=
 =?utf-8?Q?VfiPpmhIVAKdZlBDG51QdW1dn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6f85b7-a412-49a0-3ac3-08dd8bfb8dbb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 17:37:48.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNG1XyGBWMEvdhH52MZ+cUikRKkTWNHYABp1vM7U6UqnDbidocTUU7rlvK2dE+yDfKSpBLq8u/U2LONsu9pCZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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



On 5/5/25 10:32, Mario Limonciello wrote:
> On 5/5/2025 11:27 AM, Alex Hung wrote:
>> On 5/4/25 16:11, Rodrigo Siqueira wrote:
>>> DCN401 and DCN31 share the same implementation for disabling CRTC. This
>>> commit makes DCN401 use the DCN31 implementation and removes the code
>>> duplication in the DCN401.
>>
>> Hi Rodrigo
>>
>> optc31_disable_crtc is not the same as optc401_disable_crtc. Please 
>> see the dfiff below:
>>
>> < /* disable_crtc - call ASIC Control Object to disable Timing 
>> generator. */
>> < static bool optc31_disable_crtc(struct timing_generator *optc)
>> ---
>>  > /* disable_crtc */
>>  > bool optc401_disable_crtc(struct timing_generator *optc)
>> 147,148c232
>> <                       1, 100000);
>> <       optc1_clear_optc_underflow(optc);
>> ---
>>  >                       1, 150000);
>> 152,155c236,237
>>
>>
>> However, optc31_disable_crtc is the same as optc35_disable_crtc (patch 
>> 3?) and optc32_disable_crtc is the same as optc401_disable_crtc.
> 
> Is that last argument a timeout?  How about just extending the timeout 
> to be the same for all of them?  That should be relatively harmless, no?
> 

Hi Mario,

"fa28030a83a6 drm/amd/display: increase hardware status wait time" 
changed timeout from 100000 to 150000 and 401 is based on 32.

Do you mean we change all of timeout to 150000?

Hi Aurabindo,

do you have any comments?


>>
>>>
>>> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
>>> ---
>>>   .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  2 +-
>>>   .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  2 ++
>>>   .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 34 +------------------
>>>   .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  1 -
>>>   4 files changed, 4 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c 
>>> b/ drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>>> index 13c1f95b5ced..e6246e5ba86f 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
>>> @@ -125,7 +125,7 @@ bool optc31_enable_crtc(struct timing_generator 
>>> *optc)
>>>   }
>>>   /* disable_crtc - call ASIC Control Object to disable Timing 
>>> generator. */
>>> -static bool optc31_disable_crtc(struct timing_generator *optc)
>>> +bool optc31_disable_crtc(struct timing_generator *optc)
>>>   {
>>>       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h 
>>> b/ drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>>> index af67eeaf8505..db7e51fc787e 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
>>> @@ -267,6 +267,8 @@ void dcn31_timing_generator_init(struct optc 
>>> *optc1);
>>>   bool optc31_immediate_disable_crtc(struct timing_generator *optc);
>>> +bool optc31_disable_crtc(struct timing_generator *optc);
>>> +
>>>   bool optc31_enable_crtc(struct timing_generator *optc);
>>>   void optc31_set_drr(struct timing_generator *optc, const struct 
>>> drr_params *params);
>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c 
>>> b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>>> index 6eba48de58ff..f472d2efe026 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
>>> @@ -170,38 +170,6 @@ void optc401_set_h_timing_div_manual_mode(struct 
>>> timing_generator *optc, bool ma
>>>               OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
>>>   }
>>> -/* disable_crtc */
>>> -bool optc401_disable_crtc(struct timing_generator *optc)
>>> -{
>>> -    struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>> -
>>> -    REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
>>> -            OPTC_SEG0_SRC_SEL, 0xf,
>>> -            OPTC_SEG1_SRC_SEL, 0xf,
>>> -            OPTC_SEG2_SRC_SEL, 0xf,
>>> -            OPTC_SEG3_SRC_SEL, 0xf,
>>> -            OPTC_NUM_OF_INPUT_SEGMENT, 0);
>>> -
>>> -    REG_UPDATE(OPTC_MEMORY_CONFIG,
>>> -            OPTC_MEM_SEL, 0);
>>> -
>>> -    /* disable otg request until end of the first line
>>> -     * in the vertical blank region
>>> -     */
>>> -    REG_UPDATE(OTG_CONTROL,
>>> -            OTG_MASTER_EN, 0);
>>> -
>>> -    REG_UPDATE(CONTROL,
>>> -            VTG0_ENABLE, 0);
>>> -
>>> -    /* CRTC disabled, so disable  clock. */
>>> -    REG_WAIT(OTG_CLOCK_CONTROL,
>>> -            OTG_BUSY, 0,
>>> -            1, 150000);
>>> -
>>> -    return true;
>>> -}
>>> -
>>>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc)
>>>   {
>>>       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>> @@ -435,7 +403,7 @@ static struct timing_generator_funcs 
>>> dcn401_tg_funcs = {
>>>           .setup_vertical_interrupt2 = optc1_setup_vertical_interrupt2,
>>>           .program_global_sync = optc401_program_global_sync,
>>>           .enable_crtc = optc31_enable_crtc,
>>> -        .disable_crtc = optc401_disable_crtc,
>>> +        .disable_crtc = optc31_disable_crtc,
>>>           .phantom_crtc_post_enable = optc401_phantom_crtc_post_enable,
>>>           .disable_phantom_crtc = optc401_disable_phantom_otg,
>>>           /* used by enable_timing_synchronization. Not need for FPGA */
>>> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h 
>>> b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>>> index 8e795e06e615..be74fd709d43 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
>>> @@ -180,7 +180,6 @@ void optc401_program_global_sync(
>>>           int vupdate_offset,
>>>           int vupdate_width,
>>>           int pstate_keepout);
>>> -bool optc401_disable_crtc(struct timing_generator *optc);
>>>   void optc401_phantom_crtc_post_enable(struct timing_generator *optc);
>>>   void optc401_disable_phantom_otg(struct timing_generator *optc);
>>>   void optc401_set_odm_bypass(struct timing_generator *optc,
>>
> 

