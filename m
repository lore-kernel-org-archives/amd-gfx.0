Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8858ED5B16C
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 16:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B29710E52B;
	Mon, 15 Dec 2025 16:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M9K6X22S";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013044.outbound.protection.outlook.com
 [40.93.196.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3FD10E52B
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 16:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMZAmNOfLFSxy7hpyqHnmHHToTIqziX1BWJwig9I+24qL2yh8brLo3luqEbWtkBUAjg+VnEi6PsTT+m4nj5Sra+TNew3kwRLx6j+PAnmQRi1UD1tvh4tFLzApylabQYOg45EYH7zKwmI8xrG0K+UX7/ZucSOif9gxoDMsh4D3cniH8xdlHddI0JbVaRZCnitVNGf3yqYViyraIKA/NRsQDAaYaPNIPFtzbI2JiVNO2tO1blGW466LcGq4ujEtcKGJQpuMJAthNm3X8luN+uIFivDBy9vA5BI/YywShHDzxsSluTR4P4bnJ8ZcroL4zttCZlb1DbvFuOlUVSccH1mRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS6M+9x2uUHUbSsIOd2flicYOU7+wEm6lpNWvt2PwRs=;
 b=rC5dv5W2nrfs5nK/h1BSdHm+6TPuoxEu/k0TB29EqnsKlw0k8YMEvuz29H/QIRAYwi1s1IZice5lEcRNWbcWb1UsP2F6/jhf1/aeJd9vC8C/slu0z6tGc3eQQY3r2HR0BpK1hI45A7DqblLR2mXmDrSb4F01/fQRSP30PS3W0vKZXFKCuXiuBtFYlMDIvrSjq1nqHGn4kk+T30uLgiHKddGhEasrFOgRFxz/yJvJg/2ORj1zP/Vfn4QJ9pNLj4TQ3tTpWvlnov6FYgZtQOE9Sg8ZYKj5PpRTZtRYLyRpLbFpEvLBcDfaEP+vYNdb84/Hi/HeGUVqRMG6m225BB0dgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS6M+9x2uUHUbSsIOd2flicYOU7+wEm6lpNWvt2PwRs=;
 b=M9K6X22S9qeX6ZMFRaYJJP6EFJ3XfE7EFyHonO73QillHQJmjVFdHxuVPfepJkTI8JIotJUrdq8Q02Ek5ITb3Rx5Lg7KJDuPLi3AErAO429D3HG4vHQRt2x4vzLNdw6EqApr5mwez1strZawVpRemGS5Le0qLm7FtfFNEHn/SxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 16:11:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 16:11:06 +0000
Message-ID: <50dee2c9-bcfc-462b-bf46-f110a082e2d3@amd.com>
Date: Mon, 15 Dec 2025 17:11:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/8] amdgpu/amdkfd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent.Russell@amd.com,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <fbc164ab-964f-464d-b94a-80131016b5b8@amd.com>
 <871pl0567w.ritesh.list@gmail.com>
 <1f10b67a-ffdc-4962-af52-758247569e09@amd.com>
 <CADnq5_NbDzqucujDyW009+55mLXZz2PiyaSd9PKXXeXv4pYn0Q@mail.gmail.com>
 <996ef75a-71b3-4ba7-a255-40516c5e9acd@amd.com>
 <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <444bfeba-deae-4f7b-84d7-29048256b69d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 39770a0a-c567-4e90-208e-08de3bf48d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmJ3Ym1mQ3lpbnFkSmVVKzlma1RHTm43c0hlazFMSXJpeUhSeS9MTTQ3Qktr?=
 =?utf-8?B?VXh6cmF2bHZ3TVltb2RzbFEyemt2TTgraEoyME9SdWZGbmZMMzRiQWpMeVBo?=
 =?utf-8?B?RFN4TEFXeGZTNHp1OXVoYmlGZ2pSVWkzbVVGQ1hybXIzUzVjbXM1OG5YYXBN?=
 =?utf-8?B?WlhkL3J1NVpJVzVWZndHMnZNdjNyLy9XazZRYmtwUkMybzUzbkxvcEtvMlNW?=
 =?utf-8?B?ZVc5ajBPeHNKRXkrdmh3cm5Ic0k1bFdzS3hkdWt6ZGZraWlDVTVTakJRMEtE?=
 =?utf-8?B?dkpPWjVXb3dDK1RwQm9nOExCcFBEVW9pMEx1Z08vTXhQL0JFS21od2VJZWpK?=
 =?utf-8?B?ak94em5rVkZkUXhRK3EvZ0tFMEx1UEw0ZWh3OXR4ZUhSL3pQN01IRnJyWDRu?=
 =?utf-8?B?a2Q0cVRYNG5xMDZhU2l5dzREOU9WZlprVTZKcHc0NnlqV1pqaFBqckhoSjJQ?=
 =?utf-8?B?ZXNoMjlMVElISjNqaGxEdVZ3bEEvdEx4SHFHblo5VmF4NGFDRWxkYmpncmlV?=
 =?utf-8?B?cFhGVG5GSEhQVEc1UGlGM2NaR3NyUXRpTlBZNndOYTB5K0JiNGE0SDBSbVkx?=
 =?utf-8?B?czhpSjk4Smd3Y1JWak1FdGNkYkUvaEJyVC9DZGduM3huTTN2QzdXZTgzTFZu?=
 =?utf-8?B?dkVlYnJ5eVZTNzZtYzI4emh2bkE3MklzQWY2Ri9FVVZUNVpzVCtxLzkyUk44?=
 =?utf-8?B?U0lNVzZ6czk0ZERTckhOdTNJYVR1NVNudlJFc3VZeThaQ3d1SnEwSDh1U3ZY?=
 =?utf-8?B?RFBSc1NNT1FTWWJMVlpjK0gyUU5zcGtlT0NyblpJWFNiM1hXUCtqSlU1NkRB?=
 =?utf-8?B?TEl5RThNODBOZXVYQ0RwZHVtOUhuNmpJYVFSbFBuRTJCUEYwaXBZeDdqanhV?=
 =?utf-8?B?T2NZYTY0U1NkUitPVW1GL25DYVBLQS9OVytjUHg4RlhGVkRBL2hXeHRMTkJR?=
 =?utf-8?B?eng4MUhpZHFQZktQUXRhZnFxbzVFeWo4NFBnODNhTEdQR3pHQzJYOGYrQmRC?=
 =?utf-8?B?UTVHNjllb3paVFZNWE5CTTdheXlQeUIwRXVWdkNib3ZyWHpkVXZvaU1JdllY?=
 =?utf-8?B?R1RYSmhuMENzMEc3SU1QaW10MUFTQ29EOVFlOFk5RFZFTXpZUU91WWxzVnE3?=
 =?utf-8?B?eVVaNWRjdjRlQmdLeGQ2Y3hWcXR2S09Qcjl4QVV0cU9lR3A4NWRXYnVkSUV6?=
 =?utf-8?B?UjNvSHBleUVSbGZRNUl6Y2loUDZ6ejI5am16WjJ1blBnNGlhUmJ1bDE3c3Jz?=
 =?utf-8?B?OHNWc0Zva2tvVEZmTjVQMzU1ZExLYnZ2aEw4dFV4TzB1allVT3h3YnFTak9X?=
 =?utf-8?B?ODdiYnR3dFVMd1QweGpFUnVlc1BOY3VsazdkZVl3dDM2OFJzSHNVVVRHcFJ0?=
 =?utf-8?B?SjRxTzYrWDhrNVFiYXVRYm9zN3NUcFZodVcyUS9rV0dnV3g1Ym9aRXFzMFRN?=
 =?utf-8?B?bFZxNlZIdG1mZDYxZERTcERwNGlZZHBacmJDRm9TQitUMlptdGNFU1pGdUdw?=
 =?utf-8?B?c3l0NzZ4WWt3c1JSaHIvQ3ZYdXZjcWRRdURiWFc1bHBac3NjVHpxOEpHWG1Q?=
 =?utf-8?B?V2U3WmptWnRubHV4ZlVqU0VrYTErOW5zZkJxRHZjOVNzQnFSaitCZ096NHBs?=
 =?utf-8?B?eDdFSWZNckJOYUc0eEpZSzdJWFBkUjFtQjNVRHhybzAzZDl2V2dWMUdoQnlm?=
 =?utf-8?B?NnNsTVJKYTZyT1FHT3Y2TVdvWVBRdWhHMkFkdkRCNW9BVE5TUm9LK0VscVAr?=
 =?utf-8?B?bEFIblZ4eWFIQU53enBEeVZDczhwUHlrRThLWTdkUm8wVGdSbk9WNmplbVVo?=
 =?utf-8?B?NEswdUdSSGluM2RsQ2dXVUJlUTNNOFRBTzFBV0hvS2xrQVFFM2tYZDYvNWdv?=
 =?utf-8?B?OXRlODQxMW9TdkRvd01SM0JZRndzeGQwUXA5dkZGMCtDQjRPZG1JRS96UEI0?=
 =?utf-8?B?Y0tmNEJvSkowc0ZnNThnWGlaSHhNZ3BOcE5rUThxcUFYTWRlbXJJTGhITVlC?=
 =?utf-8?B?T0xQZkJxWFBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2pDSWNSQm5vWndGWmsxRjJzYzl3dy9BbG0rblEyK2NZNzhzV0t4VVkvL1Yx?=
 =?utf-8?B?RHE5YTRFd0N1REJUblBWWVc1Yk1ReXd6WUVyLzZrTjFacytPbHB1SFIwQ3ZH?=
 =?utf-8?B?aUtVSE1hU2lEUDg4cGFMbmtNNHo3QVg1cGtrMHQ0dnk0cVQ5SEdxY0MvRWU0?=
 =?utf-8?B?UGpnLzBYRFhqUzFxN0xTdnlZRGdQOVluRFZDMWx3aGxTZWhQRGdJbzVCdFB3?=
 =?utf-8?B?TmYwZW55NEplN0FydFVrUU1VbE1UbE9mc29HVHRxZmw5THVhdmxFempmWkpS?=
 =?utf-8?B?MzRaWHp3SXQxWFhpYnM3eXF3WVhuaXp0UU04Um5lci9lLy9RTlo5U3h5Z3hK?=
 =?utf-8?B?S2FjemtVeDRNcloyUTJqWEdhazhwMXlSU3RqVlZBRW5tY2pRMnZqckNhUGM3?=
 =?utf-8?B?SS9nN2RDbjQ1NjF0L2VXbTRmaU8wR20rUlh2RjRwL2NYbDYwZ3hucXIyQnY4?=
 =?utf-8?B?VEtNeTVnajNzcFo0T2lsQXB6WW5FOUhqZnpITkFLaDJWMlAxS0tIWWV6cVJ0?=
 =?utf-8?B?KzhvbHpRQUpPUFdoWGJWMTFGTDI0R3cxWXIwN2Z6VGRKSU1DTmNLNTZOQ2pF?=
 =?utf-8?B?M1lPcXNtdVhIU0htWXVKUFZjakVOT3RVbFFGTGFjY2RhU0lycUM2WEwrTXU2?=
 =?utf-8?B?WlBFVFZKVWNycjRvSVRSdC8ySFVHZEwwSUo3Wmw3RXkzalpXNG1OVmkyZVlZ?=
 =?utf-8?B?YllsUWxkVU40b2JYQVJCVklNUU5PUjQxN1NzM1FXK0dzOVNIU3p1ZGpGU2dq?=
 =?utf-8?B?WWJSU2w5b1c2S3pQMzc5NldZczVxNmhrYm9rWFlrOTJERzRtMEZpM2xuTnRU?=
 =?utf-8?B?RXE2bEI2c2VSZG9heEYwVC9BNlpiVXN0MWt6c2N5OHJRdzVJZ1JHc1BYWWoy?=
 =?utf-8?B?czRhYSttc1FRa1F0L3gwZEsxU1ZLQ2dNSm9aNHpSdTI4YXYxWWZYU2ZFcFY5?=
 =?utf-8?B?WU1oN2xkcWlzTDVobGpSaEZLb2JYVktMSXloc1hoRG9rUy9aVHFpS0IxZEQ0?=
 =?utf-8?B?K2xZS1lnTEQ3UmtSZm11UitIdWdYQmRtaitkdGVoT0dFZ1RHR2dtdDdIQllQ?=
 =?utf-8?B?VEpqQ2RpblBlVjIrTk1hT2tuejRrelhMTjJvSEJZNms5aXpxS0lvekFrU2NV?=
 =?utf-8?B?czUySVh6NE5NS2wwYXVCT2VOY1VmelhlY3lYMkw4SldBOUNhVHN2SDhkQ2cz?=
 =?utf-8?B?c1loUmtTN3JPTnpnSVBqUXZWWDZ6SzRYVEFhNmRneUxMRWFVb3Nkd0dNMjEy?=
 =?utf-8?B?eUlPa3pQdlFzR2FIZEQrdTI1SDQ4MVhpYzlYR0NSR3hFR1krT1lFanc0WS9D?=
 =?utf-8?B?NUdLNE9GaE1GQ2dyTUh5SUhKQUZDb0dyV1ZYc3M4WmlPcUZVMHRzTDdqVnhU?=
 =?utf-8?B?MEVUSVhlUzIzdEwrTStSR1NQOHB0Nm5vNE45MlA3dXNzN3A3QlhLZ3VuMDJp?=
 =?utf-8?B?MGdVQzBiVzlYUXNxUldYbU4yUVU3TzVVTVExQmRPdmxSUW9uOE15SURQS2xS?=
 =?utf-8?B?VnM4VjdEYWxId2tkTHVlYWVha1pFYm82cExrS1pnYlJMWEVaVHpCaCt4Qmxq?=
 =?utf-8?B?bERya0JnZFJTZFRhRndZdGoxQnhEUnNndGFQTTZNK1VUSFpjSTN5SS9hVFpZ?=
 =?utf-8?B?bGsySk1JSndTVmJPcXcyZ2FWUnVvRHJJcUtJd3psZHVsanN1eXpOZ1krdVhL?=
 =?utf-8?B?cnRydkxIVk1UMVZPNzRNMEl6WXdLMHgrSnpaaU9xOGc2bnhDM21TS2E2WUta?=
 =?utf-8?B?YnNCVFRybmZzTER5VTdpN05iYTZpbHFHaHhRa2lKZ0dnRklvNDVYdzB6bDJs?=
 =?utf-8?B?eUdZdXp3T2RoVFJVZDFpY0FGcFZaNmRORUtLV0JrUUs4eHA5OFBKc2d2ZWF2?=
 =?utf-8?B?eUxSenJWSHRJN0o5Y3NtMTd5bFVHYVlxdEd4MmgxeWVKeTh5S2tpbXNlQ0ds?=
 =?utf-8?B?dDM5cmJtcDduanFnNDlqVzlxZHU5ZnNPUm10OVl0T29WOGJoeGt2V2w3T0Jz?=
 =?utf-8?B?emJiWnBXRVdPeW1tZVVPcGhtOXl4T1drenVnemlqeGJEUCtPNkJZMStteVdH?=
 =?utf-8?B?eFU2UFp6dFdheVAyaXYweWllQ2ZOSGxpZnkvVkZmbEoxRjhScGpMaXlYcElu?=
 =?utf-8?Q?ibKLtxCM/7urPgWApp618eK3b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39770a0a-c567-4e90-208e-08de3bf48d30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 16:11:06.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaA7D161ui/51VP9kCOOC0U3LMbf6cHOtNHvixVZ2G9gQbuLfH3Z0py0lOp2vFvT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69
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

On 12/15/25 11:11, Donet Tom wrote:
> On 12/15/25 3:17 PM, Christian König wrote:
>> On 12/12/25 18:24, Alex Deucher wrote:
>>> On Fri, Dec 12, 2025 at 8:19 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>> On 12/12/25 11:45, Ritesh Harjani (IBM) wrote:
>>>>> Christian König <christian.koenig@amd.com> writes:
>>>>>>> Setup details:
>>>>>>> ============
>>>>>>> System details: Power10 LPAR using 64K pagesize.
>>>>>>> AMD GPU:
>>>>>>>    Name:                    gfx90a
>>>>>>>    Marketing Name:          AMD Instinct MI210
>>>>>>>
>>>>>>> Queries:
>>>>>>> =======
>>>>>>> 1. We currently ran rocr-debug agent tests [1]  and rccl unit tests [2] to test
>>>>>>>     these changes. Is there anything else that you would suggest us to run to
>>>>>>>     shake out any other page size related issues w.r.t the kernel driver?
>>>>>> The ROCm team needs to answer that.
>>>>>>
>>>>> Is there any separate mailing list or list of people whom we can cc
>>>>> then?
>>>> With Felix on CC you already got the right person, but he's on vacation and will not be back before the end of the year.
>>>>
>>>> I can check on Monday if some people are still around which could answer a couple of questions, but in general don't expect a quick response.
>>>>
>>>>>>> 2. Patch 1/8: We have a querry regarding eop buffer size Is this eop ring buffer
>>>>>>>     size HW dependent? Should it be made PAGE_SIZE?
>>>>>> Yes and no.
>>>>>>
>>>>> If you could more elaborate on this please? I am assuming you would
>>>>> anyway respond with more context / details on Patch-1 itself. If yes,
>>>>> that would be great!
>>>> Well, in general the EOP (End of Pipe) buffer contains in a ring buffer of all the events and actions the CP should execute when shaders and cache flushes finish.
>>>>
>>>> The size depends on the HW generation and configuration of the GPU etc..., but don't ask me for details how that is calculated.
>>>>
>>>> The point is that the size is completely unrelated to the CPU, so using PAGE_SIZE is clearly incorrect.
>>>>
>>>>>>> 3. Patch 5/8: also have a query w.r.t the error paths when system page size > 4K.
>>>>>>>     Do we need to lift this restriction and add MMIO remap support for systems with
>>>>>>>     non-4K page sizes?
>>>>>> The problem is the HW can't do this.
>>>>>>
>>>>> We aren't that familiar with the HW / SW stack here. Wanted to understand
>>>>> what functionality will be unsupported due to this HW limitation then?
>>>> The problem is that the CPU must map some of the registers/resources of the GPU into the address space of the application and you run into security issues when you map more than 4k at a time.
>>> Right.  There are some 4K pages with the MMIO register BAR which are
>>> empty and registers can be remapped into them.  In this case we remap
>>> the HDP flush registers into one of those register pages.  This allows
>>> applications to flush the HDP write FIFO from either the CPU or
>>> another device.  This is needed to flush data written by the CPU or
>>> another device to the VRAM BAR out to VRAM (i.e., so the GPU can see
>>> it).  This is flushed internally as part of the shader dispatch
>>> packets,
>> As far as I know this is only done for graphics shader submissions to the classic CS interface, but not for compute dispatches through ROCm queues.
>>
>> That's the reason why ROCm needs the remapped MMIO register BAR.
>>
>>> but there are certain cases where an application may want
>>> more control.  This is probably not a showstopper for most ROCm apps.
>> Well the problem is that you absolutely need the HDP flush/invalidation for 100% correctness. It does work most of the time without it, but you then risk data corruption.
>>
>> Apart from making the flush/invalidate an IOCTL I think we could also just use a global dummy page in VRAM.
>>
>> If you make two 32bit writes which are apart from each other and then a read back a 32bit value from VRAM that should invalidate the HDP as well. It's less efficient than the MMIO BAR remap but still much better than going though an IOCTL.
>>
>> The only tricky part is that you need to get the HW barriers with the doorbell write right.....
>>
>>> That said, the region is only 4K so if you allow applications to map a
>>> larger region they would get access to GPU register pages which they
>>> shouldn't have access to.
>> But don't we also have problems with the doorbell? E.g. the global aggregated one needs to be 4k as well, or is it ok to over allocate there?
>>
>> Thinking more about it there is also a major problem with page tables. Those are 4k by default on modern systems as well and while over allocating them to 64k is possible that not only wastes some VRAM but can also result in OOM situations because we can't allocate the necessary page tables to switch from 2MiB to 4k pages in some cases.
> 
> 
> Sorry, Cristian — I may be misunderstanding this point, so I would appreciate some clarification.
> 
> If the CPU page size is 64K and the GPU page size is 4K, then from the GPU side the page table entries are created and mapped at 4K granularity, while on the CPU side the pages remain 64K. To map a single CPU page to the GPU, we therefore need to create multiple GPU page table entries for that CPU page.

The GPU page tables are 4k in size no matter what the CPU page size is and there is some special handling so that we can allocate them even under memory pressure. Background is that you sometimes need to split up higher order pages (1G, 2M) into lower order pages (2M, 4k) to be able to swap things to system memory for example and for that you need some an extra layer of page tables.

The problem is now that those 4k pages are rounded up to your CPU page size, resulting in both wasting quite some memory as well as messing up the special handling to not run into OOM situations when swapping things to system memory....

What we could potentially do is to switch to 64k pages on the GPU as well (the HW is flexible enough to be re-configurable), but that is tons of changes and probably not easily testable.

Regards,
Christian.

> 
> We found that this was not being handled correctly in the SVM path and addressed it with the change in patch 2/8.
> 
> Given this, if the memory is allocated and mapped in GPU page-size (4K) granularity on the GPU side, could you please clarify how memory waste occurs in this scenario?
> 
> Thank you for your time and guidance.
> 
> 
>>
>> Christian.
>>
>>> Alex
>>>
>>>>>>> [1] ROCr debug agent tests: https://github.com/ROCm/rocr_debug_agent
>>>>>>> [2] RCCL tests: https://github.com/ROCm/rccl/tree/develop/test
>>>>>>>
>>>>>>>
>>>>>>> Please note that the changes in this series are on a best effort basis from our
>>>>>>> end. Therefore, requesting the amd-gfx community (who have deeper knowledge of the
>>>>>>> HW & SW stack) to kindly help with the review and provide feedback / comments on
>>>>>>> these patches. The idea here is, to also have non-4K pagesize (e.g. 64K) well
>>>>>>> supported with amd gpu kernel driver.
>>>>>> Well this is generally nice to have, but there are unfortunately some HW limitations which makes ROCm pretty much unusable on non 4k page size systems.
>>>>> That's a bummer :(
>>>>> - Do we have some HW documentation around what are these limitations around non-4K pagesize? Any links to such please?
>>>> You already mentioned MMIO remap which obviously has that problem, but if I'm not completely mistaken the PCIe doorbell BAR and some global seq counter resources will also cause problems here.
>>>>
>>>> This can all be worked around by delegating those MMIO accesses into the kernel, but that means tons of extra IOCTL overhead.
>>>>
>>>> Especially the cache flushes which are necessary to avoid corruption are really bad for performance in such an approach.
>>>>
>>>>> - Are there any latest AMD GPU versions which maybe lifts such restrictions?
>>>> Not that I know off any.
>>>>
>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.
>>>>>>
>>>>> - Maybe we should also document, what will work and what won't work due to these HW limitations.
>>>> Well pretty much everything, I need to double check how ROCm does HDP flushing/invalidating when the MMIO remap isn't available.
>>>>
>>>> Could be that there is already a fallback path and that's the reason why this approach actually works at all.
>>>>
>>>>>> What we can do is to support graphics and MM, but that should already work out of the box.>
>>>>> So these patches helped us resolve most of the issues like SDMA hangs
>>>>> and GPU kernel page faults which we saw with rocr and rccl tests with
>>>>> 64K pagesize. Meaning, we didn't see this working out of box perhaps
>>>>> due to 64K pagesize.
>>>> Yeah, but this is all for ROCm and not the graphics side.
>>>>
>>>> To be honest I'm not sure how ROCm even works when you have 64k pages at the moment. I would expect much more issue lurking in the kernel driver.
>>>>
>>>>> AFAIU, some of these patches may require re-work based on reviews, but
>>>>> at least with these changes, we were able to see all the tests passing.
>>>>>
>>>>>> I need to talk with Alex and the ROCm team about it if workarounds can be implemented for those issues.
>>>>>>
>>>>> Thanks a lot! That would be super helpful!
>>>>>
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>> Thanks again for the quick response on the patch series.
>>>> You are welcome, but since it's so near to the end of the year not all people are available any more.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> -ritesh

