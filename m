Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D7FD2ECF7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC3C10E613;
	Tue, 20 Jan 2026 14:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0w6RenC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011043.outbound.protection.outlook.com
 [40.93.194.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECE410E612
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 14:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6Q+e8jZPuebcFv3rO0lJg74OS+lABbgWgPcxsXuUDiLhw3Y2cAWpe4nRuywrqGfg1f4ebk1dGmJO5QKNAcLtZB6H0woCCPdvm+QI7Fvohan+JqbPVfnPgYawbf9Mz2mDGwk07TNQbrOqCU005mQlumSKERvhqePYujTx/OORhBvarkC7qijskwH+n4SAI7P47ERot6vrAJ+33Cz/HoR6vOMk3EnDGxbzK+2FTemawrbWK1sjP0ATWSDepYcB+yJrPx8lRIQCEEEF+nsmgNaKlJUntYfYDtHpfja+izYnLHvAvcKmcfNCQWSCL0OMONPMcFvajNmjRHLRMP67r1Yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l6bPr4Pr9m/vpF9SvH6PAntOfRtCu63lCEkwuJuLmE=;
 b=iMpCrOyRtsX4hQd4mZZNUkOmNlgyJ3HIca6oCiGC1Wdj9MSbg4mpxlVbpt4uU/2HHi7Xs0LiPOisw78D+ja4CaRab9iBaBAClpi3LNc0f6cvez1BOw3sZ0uChpVXz9lI2rqRljCNHwvUyQbSHJZSTdaZsRJi8DYF+XcLCsOobCmnCWTOPJ/M5qud3APsCQzYftPnQ6A/ImupDgN3e+XR5E67tap+vwa3Iw89ZafYKTSuibjxuqnt37Ox7CCDQaMvPkw1tky+Ezb107onKh7BBZ63cKNEJGgRoAP78fuN0gVs3F7Dr4ZxPQkTxYqK2mdb4L1PabJmfSsHSJ0hVQqo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l6bPr4Pr9m/vpF9SvH6PAntOfRtCu63lCEkwuJuLmE=;
 b=l0w6RenCvs1Pdlh9AWUenZ1myPL3l+rj2a5nGuaVmTeTQ7zYFhevVehrAShffCXJyIfBF8v8jIq+ejPJ4o6OZeJjJLiV9zzbCOaMMmmQdgIqaHOwwz+J141fXZvzwn+dnyepZ7sDT4mBUGaZtWrfw07DCCkl5erJ8Zd4nODd4j8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:39:51 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 14:39:51 +0000
Content-Type: multipart/alternative;
 boundary="------------g2ejjMYxD3kRJ4OgdCl65nmP"
Message-ID: <3676a7eb-0a81-4165-bd8d-0905cff7dea2@amd.com>
Date: Tue, 20 Jan 2026 09:39:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add mask for debug trap flag setting
To: "Six, Lancelot" <Lancelot.Six@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20260119171503.624080-1-James.Zhu@amd.com>
 <CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0165.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::22) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: a78e0950-0143-49fc-88a5-08de5831c4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDJZTlMyOE5XdW90czNPZUprTVdNbWJ3Rkw0TVlhY0NlWVRTZEp3WU5WTXpl?=
 =?utf-8?B?WThMUGtyMHJ0ZXVuQ3c0N3dUNU9hTVEzdEdUR3RDSGxpSE92aGU0OHF0b2VZ?=
 =?utf-8?B?aFllTC91dDBvS3VGSlJFTVRUcUJZN29nSmVjQWxVZXRyRllBL2ttTzgwVDh2?=
 =?utf-8?B?VFdyZEtiaEhVankyVk43aURISEh2NDlFSkRZdU5JNHpXTmdUUG44Q3dmNnZ0?=
 =?utf-8?B?SDRrbHlkdGNzZ3BzL2tDMlQ1cUdhc1NnZWdjaHhqbXQ1TDFnZ1VtbjFCT0xz?=
 =?utf-8?B?QllFOTRYZE9KVG9LTS84K25VQm1rSFZhejlPeXY5eUYxY0RsVmh4NWdWbFF5?=
 =?utf-8?B?S05mT295V1hodkNNR05sVk02by9sbldON2pBcEw0NmFxeEZOdlJ5S2J2WTZa?=
 =?utf-8?B?aEtRZlpLY25ROXR0TmpEdEtHcTkxdHRLVE8wOUtwUkJseW42VU1zVUpGY29I?=
 =?utf-8?B?bGFwckFLS0xRUm1QeUhjZSsvcG9SZXBuNHNIM1R0RGxBZGJmRlY3QS9KMVpu?=
 =?utf-8?B?R1c1NU15cnNNMVVGeEpNdUlFYm9nQXMyVDNwb0RidUVsN3o5ejc3TytxcUtC?=
 =?utf-8?B?Tzc1eEFUNFVpZlVESGRSVzRDdzh1Ui9TbFlKUlNLNWtPM2NsVnNDOEZoWlpu?=
 =?utf-8?B?WXhNL0ZUMEFoTjFsbnhyRzNaNkpzVi9QK0hqSUZ1LzQwZ3Nhck1obmZ2eklR?=
 =?utf-8?B?YStCL1F1YW9TeUkwa1FsbVR4V0JISHpidzJOWU9EeXpkb1RLS3ZqdmoyWGpV?=
 =?utf-8?B?SG1qTnFXMGk5ZTQzaytPSWJiU0VycFZJSDRkWkdDZzBkZjhpcmw2bWl5SkxI?=
 =?utf-8?B?UmRTL3NoL2FvcWk3ek91UW5Vbm15RHB1ZzY0ZWQ3L1I4TGZTdlZhcHBvM2Ji?=
 =?utf-8?B?WnhjeE9sN0NURmpJNmF6cjhMdExyeHN4QkVLanpTRDlQT0dEMUhBRmpQalps?=
 =?utf-8?B?aUF3SzVVVXR1amFCTVdvL05zUk12MjJYSElIdEs5VWZ3M2hxL1dqaWNtZlN4?=
 =?utf-8?B?V1NPSDBWZHl3MVpwNUhzdnBlQkgyWG1OUURiV3hhMzhkd003TXEyYkxraUhQ?=
 =?utf-8?B?T2NmSXpyejFCWjZVbDF4S0xkZHowUUdUMHV5WE5ZVnY3bDMyMnBrQ2YvZTRK?=
 =?utf-8?B?bWhoRGIxcTZEcW56OEdnOWdFK0daNVZUTVRsa3lHak1uTndWVnJTK0N6cjZo?=
 =?utf-8?B?eW5Xb1BOT3lwT2hGcmgvTlhBeXdkaURLZzNNNHFPODVqcGJxUGxSVWFYUjlL?=
 =?utf-8?B?TXRBV0NIdlFCN1piSE5wM1JFRXAxcVR3ek5LNHN1cHhaakJuKy9xTVRRekhX?=
 =?utf-8?B?eVA1dkFaSDdjaEVtYU9FUUFSVExKVVlVbXlPcFJKM2ZsZ2VjYUNUWjM0a09a?=
 =?utf-8?B?M2lxM2xkbGJXU2Uva29jTTNKUGpNUzN6Z25NR0xEcURZUFFWaDRIeVJ3dUlX?=
 =?utf-8?B?ZzRhTEhaOVJFcG1XaEFIeDhTSXY4RCt2UlJuNW1XU3VqbXNBcXFpUFhRd25y?=
 =?utf-8?B?enFDTkZieEtzVElhQ2NNVXpwZUEwSzNJNEZERXZsQzZlNFRKbnZVNUIzSWlp?=
 =?utf-8?B?VkZtSGI5dGx5QXhtdjVXVTFtdEI0ZS9rdGl1R1VUVnQyRnVFcERyeXI5SkQv?=
 =?utf-8?B?aGJvV2xIcndjUFduVXdiaUdkcUtlRk5oM3RPMTNNbVNoYmNISUR4MlF6cURS?=
 =?utf-8?B?dEYyaHpnSzhVV0ZxaGZUMjA4UVcxRm0zdlRCQm5ZaXQ3SWV2ZHZCYk9EQ2N6?=
 =?utf-8?B?aGRaR1FxZnd4T2pMREY0YWlzV3BIV2JVQ1J4WHlLdWJadWF0YUlRclN6ZzAz?=
 =?utf-8?B?OEFIT055R1QyR0xra1VOOEdTeG1DYjZWWkJLcFd0aTNOdHphcG1CVEV4aUpX?=
 =?utf-8?B?ckxHcGpaTFJZWlpJVk03cUJ3eGdHNmVwRlBJVHplQk9pM25Mc0VzVFo4RDdk?=
 =?utf-8?B?Z0VreHB4L1BCNURlOThlTEZZMUtoUEp4Yzc1d3EwenB3Y2syeDVtYTBoMlM1?=
 =?utf-8?B?R2JDNWhUMUdtUGV4VFRwMkppSm8ycTkveXBpUC9teE5sbzNRczZBa2JCWkor?=
 =?utf-8?B?YnhubGRRV3pWNVF4c0JGdXVWMW1FSXlEVEVOWENIc0Zhd0lPMFFZclF6aGpP?=
 =?utf-8?Q?1KMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlh5V1U3bDcxQTg0amRHWDdrY2MycXBBd1ljWlErRlpDTUpvd3AyWmNSZW83?=
 =?utf-8?B?alEvaW15MVNEUmovKzhaY2pnUkF6VmRvWlNkZnBaOXdVanVnUHhoaGlSME96?=
 =?utf-8?B?eVB6YnNQdWZBVVNBc1dvSnIrWXNxcDRqVHc4NGhnOHEyVUtOK2tLZS80T0dJ?=
 =?utf-8?B?T0h3emQ2ZTlPYlBwdFpSd1djR0xVNWduRjUzZVgzenQwaER4TUd0WXdLcEFV?=
 =?utf-8?B?Mm95a3lHQ2pPOXI0UUVPTE5jR3NtTDlDdkJNOE1PcE9GdW9JQ2dOOC9vZkFa?=
 =?utf-8?B?MkZzVDFsNytpQ25QYmNJVjVVOVJXU1E5K0llQTc3L04wMkZwVWhhWHFITDBI?=
 =?utf-8?B?MEpLNDhVUGZEOHBuaXM3N3pJellwWWRHSWxwMXdiTXBqcTRBT0tVZ0ZwS3BF?=
 =?utf-8?B?aXFGclJ5blhDazdNNGpUZFVUc0JpL3FxdzhVblF5dHVSczZBRjVFYi9xdXFP?=
 =?utf-8?B?MGZibHlNSmtWNmFEdEpwNDNZelF1Ni9pZmZLSHN1OHZUWUovbTUvMzhHMWZ1?=
 =?utf-8?B?d1g5c05GT1c4YlBJS1pGSFpkZkM1c3VHV0pJV1Z5ei95YmhjV29YWGhRWmZn?=
 =?utf-8?B?L0ZtY2dTSVQ5QVhCRG1Jd0d1bUVacXFPRkIyck4rV016d2VROThjQlU1cFNX?=
 =?utf-8?B?RmNHYzJVcjZma09hQklka2R3d25Oc1A1VGdSRitmamtpdVpWTlpTSW1mMjlQ?=
 =?utf-8?B?TkdvZnZSbHQvTmdpNkg4NDZzbjZMTkhDOUNxMWRBTWVKN2RrSC84dUNnbG1l?=
 =?utf-8?B?VGkvVEI2NWZGbVhKb1o3V3lxUXVWL0crdWNLMzVnMHJTZDVKcGhMdG9RWGRS?=
 =?utf-8?B?R285THYwckRxRTNuTUNHQ1V4YjFHN09KVkFpT0xBTmV5Q3BOaWZsMkROOFc2?=
 =?utf-8?B?ZVA2K0Y2QUdvcmFGTzBZRTZObUJFeURoK21Kdk85M1J2YzVTWWFPQmdVc0o5?=
 =?utf-8?B?MVltRWRQSTl2RVoxMDNRZHpPTjVlcTdka3V3RDZFZ3gyWGJ3QTRpSGQwaUlC?=
 =?utf-8?B?YzdIT3JiQldsRnZORWpoZmV2TjRhOE1PRkJwY2I2QnpDc1hoNG90M0RxdE9J?=
 =?utf-8?B?Z1RzdjJvcC93UVl2NnR5Qk1Uc1lFWnlmd0NaNGI2Vmk0Z3Y4cVNzbXNmRjhk?=
 =?utf-8?B?ckh4aTNabEJ1VjQydzE5c0dRUHVub2ljNHFVN3h5VVpVMVpDQ2xRS0hhZU5n?=
 =?utf-8?B?Syt0Um04Ri9rQjhQbDFUYWlBcjJjMHRkR3l4bHZyUC8yTGMrNWhKN0JlVk8y?=
 =?utf-8?B?aElETW55ZzN5TFFOT2ZXUmJRUDRROEN4QVR6dloyeDFPUG1YTnhkWXdKVytE?=
 =?utf-8?B?K0tNdndVRzdDUEgva0RXQi9ZOWlXZzVKZjlJUVFwSVZmVTFZTGVoV0ptWG8z?=
 =?utf-8?B?WGpFUG81MVN4R3ZVU0VReU04Tjk4N0FQVXhhaWVTVWtuNTIxT1htYis5ZHhD?=
 =?utf-8?B?dS9hcVlRaGhQNkdCNzUyUmVlaGpqWjFoWTBKQlJ6NStyNXAzYlhKY2lKN3V6?=
 =?utf-8?B?dEU1SWtsclJoVHphSFoxVDBKcU9xMFQ5cWhSZHNndGx3Uks3WTdwSkpRUE0v?=
 =?utf-8?B?QkFuemtBcDU2WVN0QjRZcWtTWDA4TlVoVkVocnVyRGZBSkRLZFdUUW53WTBs?=
 =?utf-8?B?ZDVKMUQwc05qZEIzK0JRT2JLcmhTTExXM2c5Zm1pZmxxQXR6U1d0NzN2Um9Z?=
 =?utf-8?B?bFowYktJL1E0S2pDelJoQ2Ztc1hNVmtBaUMwT0oxdkJUZDVMNVd4RDQyTHpY?=
 =?utf-8?B?ZElENTEyeXBqQk5hcVlINnEyRzAzTTF5a3VyK3lueEFMN1g0U3hDbDhOM25i?=
 =?utf-8?B?OXpMU3NWTmlId2NzNWg3dlRWWjFiZ1hrUnIxNlhBS1dKeFNmMlRtN3pOT29u?=
 =?utf-8?B?a2plNVVRTmp4OTdSaHM3dDJlWlRUSGJSdERZVEluQmJWOHZvMEhyR0RFQVND?=
 =?utf-8?B?TEZ2b3NIMDc1aWlTOCtURXoxemQ0SHBKSklqY3lYdFVUMnpzVlRYaUt5b0ox?=
 =?utf-8?B?V1VHd0x1NVBvYVhIN1BicnlweXVVVExVWEM4amw0Qm9mVjM2MFhTb0N2czN4?=
 =?utf-8?B?NHpHMzJyQjRIUHZsTmRuSVlTdU15Q2p5Q3V1bWtNdzZHeVdhb0djU0NMZWdD?=
 =?utf-8?B?YmRHbTU0Ly9XNEttcUNrUFNsaFZraXZjNG9MUjVWVjA3K2t0TzFMUFFsQktu?=
 =?utf-8?B?a3lJQlFRQXUwaVlUZ2IrV1NzM0RnUFhpYjF6QVliSkUyMDU2akw3RTZGcTAy?=
 =?utf-8?B?ZGpYa291a2Q3Z2krOHlSRElrVHEyMDN1Qk1NZG5nVkhMVlhReHJzUGVDSDVS?=
 =?utf-8?Q?+2TTEPs2x7d3z5JZ6M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e0950-0143-49fc-88a5-08de5831c4f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:39:51.7356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3Ug7sISSSAGocSuckH/2UEdC3DQqTIkzaZGedxFkiK7ImpVRKNF5PfYsDM4rcwl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460
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

--------------g2ejjMYxD3kRJ4OgdCl65nmP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-01-20 05:34, Six, Lancelot wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi,
>
>
>> -----Original Message-----
>> From: Zhu, James<James.Zhu@amd.com>
>> Sent: 19 January 2026 17:15
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Six, Lancelot<Lancelot.Six@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; Zhu, James<James.Zhu@amd.com>
>> Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting
>>
>> to specify which bits are valid setting on flags.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
>>   include/uapi/linux/kfd_ioctl.h           |  3 +-
>>   4 files changed, 30 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 79586abad7fd..fd43ef7c9076 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep,
>> struct kfd_process *p, v
>>                                args->clear_node_address_watch.id);
>>                break;
>>        case KFD_IOC_DBG_TRAP_SET_FLAGS:
>> -             r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
>> +             r = kfd_dbg_trap_set_flags(target, &args->set_flags);
>>                break;
>>        case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
>>                r = kfd_dbg_ev_query_debug_event(target,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> index a04875236647..279160ca71a9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> @@ -512,38 +512,42 @@ static void
>> kfd_dbg_clear_process_address_watch(struct kfd_process *target)
>>                        kfd_dbg_trap_clear_dev_address_watch(target-
>>> pdds[i], j);
>>   }
>>
>> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> +     struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
>>   {
>>        uint32_t prev_flags = target->dbg_flags;
>>        int i, r = 0, rewind_count = 0;
>>
>> +     if (!((set_flags->flags ^ prev_flags) & set_flags->mask))
>> +             return 0;
>> +
>>        for (i = 0; i < target->n_pdds; i++) {
>>                struct kfd_topology_device *topo_dev =
>>                                kfd_topology_device_by_id(target->pdds[i]-
>>> dev->id);
>>                uint32_t caps = topo_dev->node_props.capability;
>>                uint32_t caps2 = topo_dev->node_props.capability2;
>> +             struct amdgpu_device *adev = target->pdds[i]->dev->adev;
>>
>> -             if (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>> -                     (*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
>> -                     *flags = prev_flags;
>> -                     return -EACCES;
>> -             }
>> -
>> -             if (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>> -                 (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
>> -                     *flags = prev_flags;
>> -                     return -EACCES;
>> -             }
>> -
>> -             if (!(caps2 &
>> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
>> -                 (*flags &
>> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
>> -                     *flags = prev_flags;
>> +             if (set_flags->mask == 0xFFFFFFFF && !set_flags->flags)
>> +                     break;
>> +             if ((!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>> +                     (set_flags->mask &
>> KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
>> +                     (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>> +                 (set_flags->mask & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP))
>> ||
>> +                     (!(caps2 &
>> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
>> +                 (set_flags->mask &
>> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {
>> +                     set_flags->flags = prev_flags;
>> +                     dev_dbg(adev->dev, "Debug Trap set mask 0x%x caps
>> 0x%x caps2 0x%x",
>> +                             set_flags->mask, caps, caps2);
> The logic here seems odd.  If "set_flags->mask" is the set of flags a caller wants to modify (I don't think it should, see below), a call which asks for PRECISE_MEMORY to be disabled would return EACCESS if PRECISE_MEMORY is not supported.  Before this patch, it would have been perfectly valid set (or confirm) the PRECISE_MEMORY flag to 0.
> [JZ] the logical here is checking input setting, if caps does not support such feature, mask trys to set this feature bit, then exit with -EACCESS.
> Also, consider the following scenario where a user wants to set PRECISE_ALU=0 and PRECISE_MEMORY=1:
>
>    set_flags->flags = KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP;
>    set_flags->mask = KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP | KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP;
>
> If the platform only supports PRECISE_MEMORY (like gfx11 for example), the call would erroneously fail with EACCESS.  This was possible before this patch.

[JZ] then mask should not include KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP which 
tells user want to clear KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP on this

ASIC, but it actually not been supported. err tells user that the 
operation clearing PRECISE_ALU is invalid.

>
>>                        return -EACCES;
>>                }
>>        }
>>
>> -     target->dbg_flags = *flags;
>> -     *flags = prev_flags;
>> +     target->dbg_flags ^= (target->dbg_flags ^ set_flags->flags) & set_flags-
>>> mask;
>> +     pr_debug("Debug Trap previous flags 0x%x set flags 0x%x set mask
>> 0x%x target flags 0x%x",
>> +             prev_flags, set_flags->flags, set_flags->mask, target->dbg_flags);
>> +
>> +     set_flags->flags = prev_flags;
>>        for (i = 0; i < target->n_pdds; i++) {
>>                struct kfd_process_device *pdd = target->pdds[i];
>>
>> @@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> uint32_t *flags)
>>                else
>>                        r = kfd_dbg_set_mes_debug_mode(pdd, true);
>>
>> -             if (r) {
>> -                     target->dbg_flags = prev_flags;
>> +             if (r)
>>                        break;
>> -             }
>>
>>                rewind_count++;
>>        }
>> @@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process
>> *target, bool unwind, int unwind
>>        int i;
>>
>>        if (!unwind) {
>> -             uint32_t flags = 0;
>> +             struct kfd_ioctl_dbg_trap_set_flags_args set_flags = {0,
>> 0xFFFFFFFF};
>>                int resume_count = resume_queues(target, 0, NULL);
>>
>>                if (resume_count)
>> @@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process
>> *target, bool unwind, int unwind
>>                kfd_dbg_clear_process_address_watch(target);
>>                kfd_dbg_trap_set_wave_launch_mode(target, 0);
>>
>> -             kfd_dbg_trap_set_flags(target, &flags);
>> +             kfd_dbg_trap_set_flags(target, &set_flags);
>>        }
>>
>>        for (i = 0; i < target->n_pdds; i++) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> index 894753818cba..34d27eb500a5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> @@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
>> kfd_process_device *pdd,
>>                                        uint32_t watch_address_mask,
>>                                        uint32_t *watch_id,
>>                                        uint32_t watch_mode);
>> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
>> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> +             struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
>>   int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
>>                uint32_t source_id,
>>                uint32_t exception_code,
>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>> index e9b756ca228c..0522fe7344e4 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -1515,6 +1515,7 @@ struct
>> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>>    *     Sets flags for wave behaviour.
>>    *
>>    *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
>> + *     @mask  (IN)     - IN = specified debug trap operation bits on flag
> I am not sure I fully understand this comment.  Is it meant to say which bits from FLAGS will be set?
>
> Also, this seems to break backwards compatibility.  Before this patch, a caller would call this ioctl with "flags" set, and the PAD field would be 0.  The semantics of this call is to set all bits from flags.  The updated semantics of MASK would make it so no flags are set instead of alle.
[JZ] Jon has pointed out this. I have a new version to fix it.  I will 
add below code fallback to old version.
     if (!set_flags->mask)
         set_flags->mask = set_flags->flags;

>
> The updated ioctl must preserve this existing pattern, so instead of mask telling which bits must be changed, it should specify which bits should be preserved (or ignored from FLAGS).
>
> To make it clearer, I'd probably call this "preserve_mask"
[JZ] to use mask to tell which bits in flag will be modified seem more 
straightforward.
>
>          @preserve_mask (IN)     - IN = Specify flags which must not be modified.
>
> Best,
> Lancelot.
>
>>    *
>>    *     Generic errors apply (see kfd_dbg_trap_operations).
>>    *     Return - 0 on SUCCESS.
>> @@ -1522,7 +1523,7 @@ struct
>> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>>    */
>>   struct kfd_ioctl_dbg_trap_set_flags_args {
>>        __u32 flags;
>> -     __u32 pad;
>> +     __u32 mask;
>>   };
>>
>>   /**
>> --
>> 2.34.1
--------------g2ejjMYxD3kRJ4OgdCl65nmP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-01-20 05:34, Six, Lancelot
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[AMD Official Use Only - AMD Internal Distribution Only]

Hi,


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: 19 January 2026 17:15
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Six, Lancelot <a class="moz-txt-link-rfc2396E" href="mailto:Lancelot.Six@amd.com">&lt;Lancelot.Six@amd.com&gt;</a>; Kim, Jonathan
<a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting

to specify which bits are valid setting on flags.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  3 +-
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 79586abad7fd..fd43ef7c9076 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep,
struct kfd_process *p, v
                              args-&gt;clear_node_address_watch.id);
              break;
      case KFD_IOC_DBG_TRAP_SET_FLAGS:
-             r = kfd_dbg_trap_set_flags(target, &amp;args-&gt;set_flags.flags);
+             r = kfd_dbg_trap_set_flags(target, &amp;args-&gt;set_flags);
              break;
      case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
              r = kfd_dbg_ev_query_debug_event(target,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index a04875236647..279160ca71a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -512,38 +512,42 @@ static void
kfd_dbg_clear_process_address_watch(struct kfd_process *target)
                      kfd_dbg_trap_clear_dev_address_watch(target-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">pdds[i], j);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre"> }

-int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
+int kfd_dbg_trap_set_flags(struct kfd_process *target,
+     struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
 {
      uint32_t prev_flags = target-&gt;dbg_flags;
      int i, r = 0, rewind_count = 0;

+     if (!((set_flags-&gt;flags ^ prev_flags) &amp; set_flags-&gt;mask))
+             return 0;
+
      for (i = 0; i &lt; target-&gt;n_pdds; i++) {
              struct kfd_topology_device *topo_dev =
                              kfd_topology_device_by_id(target-&gt;pdds[i]-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">dev-&gt;id);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">              uint32_t caps = topo_dev-&gt;node_props.capability;
              uint32_t caps2 = topo_dev-&gt;node_props.capability2;
+             struct amdgpu_device *adev = target-&gt;pdds[i]-&gt;dev-&gt;adev;

-             if (!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &amp;&amp;
-                     (*flags &amp; KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
-                     *flags = prev_flags;
-                     return -EACCES;
-             }
-
-             if (!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &amp;&amp;
-                 (*flags &amp; KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
-                     *flags = prev_flags;
-                     return -EACCES;
-             }
-
-             if (!(caps2 &amp;
HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &amp;&amp;
-                 (*flags &amp;
KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
-                     *flags = prev_flags;
+             if (set_flags-&gt;mask == 0xFFFFFFFF &amp;&amp; !set_flags-&gt;flags)
+                     break;
+             if ((!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &amp;&amp;
+                     (set_flags-&gt;mask &amp;
KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
+                     (!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &amp;&amp;
+                 (set_flags-&gt;mask &amp; KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP))
||
+                     (!(caps2 &amp;
HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &amp;&amp;
+                 (set_flags-&gt;mask &amp;
KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {
+                     set_flags-&gt;flags = prev_flags;
+                     dev_dbg(adev-&gt;dev, &quot;Debug Trap set mask 0x%x caps
0x%x caps2 0x%x&quot;,
+                             set_flags-&gt;mask, caps, caps2);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The logic here seems odd.  If &quot;set_flags-&gt;mask&quot; is the set of flags a caller wants to modify (I don't think it should, see below), a call which asks for PRECISE_MEMORY to be disabled would return EACCESS if PRECISE_MEMORY is not supported.  Before this patch, it would have been perfectly valid set (or confirm) the PRECISE_MEMORY flag to 0.
[JZ] the logical here is checking input setting, if caps does not support such feature, mask trys to set this feature bit, then exit with -EACCESS.
Also, consider the following scenario where a user wants to set PRECISE_ALU=0 and PRECISE_MEMORY=1:

  set_flags-&gt;flags = KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP;
  set_flags-&gt;mask = KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP | KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP;

If the platform only supports PRECISE_MEMORY (like gfx11 for example), the call would erroneously fail with EACCESS.  This was possible before this patch.</pre>
    </blockquote>
    <p>[JZ] then mask should not include <span style="white-space: pre-wrap">KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP which tells user want to clear </span><span style="white-space: pre-wrap">KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP on this </span></p>
    <p><span style="white-space: pre-wrap">ASIC, but it actually not been supported. err tells user that the operation clearing </span><span style="white-space: pre-wrap">PRECISE_ALU is invalid.</span></p>
    <blockquote type="cite" cite="mid:CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">                      return -EACCES;
              }
      }

-     target-&gt;dbg_flags = *flags;
-     *flags = prev_flags;
+     target-&gt;dbg_flags ^= (target-&gt;dbg_flags ^ set_flags-&gt;flags) &amp; set_flags-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">mask;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">+     pr_debug(&quot;Debug Trap previous flags 0x%x set flags 0x%x set mask
0x%x target flags 0x%x&quot;,
+             prev_flags, set_flags-&gt;flags, set_flags-&gt;mask, target-&gt;dbg_flags);
+
+     set_flags-&gt;flags = prev_flags;
      for (i = 0; i &lt; target-&gt;n_pdds; i++) {
              struct kfd_process_device *pdd = target-&gt;pdds[i];

@@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target,
uint32_t *flags)
              else
                      r = kfd_dbg_set_mes_debug_mode(pdd, true);

-             if (r) {
-                     target-&gt;dbg_flags = prev_flags;
+             if (r)
                      break;
-             }

              rewind_count++;
      }
@@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process
*target, bool unwind, int unwind
      int i;

      if (!unwind) {
-             uint32_t flags = 0;
+             struct kfd_ioctl_dbg_trap_set_flags_args set_flags = {0,
0xFFFFFFFF};
              int resume_count = resume_queues(target, 0, NULL);

              if (resume_count)
@@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process
*target, bool unwind, int unwind
              kfd_dbg_clear_process_address_watch(target);
              kfd_dbg_trap_set_wave_launch_mode(target, 0);

-             kfd_dbg_trap_set_flags(target, &amp;flags);
+             kfd_dbg_trap_set_flags(target, &amp;set_flags);
      }

      for (i = 0; i &lt; target-&gt;n_pdds; i++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 894753818cba..34d27eb500a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
kfd_process_device *pdd,
                                      uint32_t watch_address_mask,
                                      uint32_t *watch_id,
                                      uint32_t watch_mode);
-int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
+int kfd_dbg_trap_set_flags(struct kfd_process *target,
+             struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
 int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
              uint32_t source_id,
              uint32_t exception_code,
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index e9b756ca228c..0522fe7344e4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1515,6 +1515,7 @@ struct
kfd_ioctl_dbg_trap_clear_node_address_watch_args {
  *     Sets flags for wave behaviour.
  *
  *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
+ *     @mask  (IN)     - IN = specified debug trap operation bits on flag
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I am not sure I fully understand this comment.  Is it meant to say which bits from FLAGS will be set?

Also, this seems to break backwards compatibility.  Before this patch, a caller would call this ioctl with &quot;flags&quot; set, and the PAD field would be 0.  The semantics of this call is to set all bits from flags.  The updated semantics of MASK would make it so no flags are set instead of alle.</pre>
    </blockquote>
    [JZ] Jon has pointed out this. I have a new version to fix it.&nbsp; I
    will add below code fallback to old version.<br>
    &nbsp;&nbsp;&nbsp; if (!set_flags-&gt;mask)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_flags-&gt;mask = set_flags-&gt;flags;<br>
    <br>
    <blockquote type="cite" cite="mid:CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

The updated ioctl must preserve this existing pattern, so instead of mask telling which bits must be changed, it should specify which bits should be preserved (or ignored from FLAGS).

To make it clearer, I'd probably call this &quot;preserve_mask&quot;</pre>
    </blockquote>
    [JZ] to use mask to tell which bits in flag will be modified seem
    more straightforward.<br>
    <blockquote type="cite" cite="mid:CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

        @preserve_mask (IN)     - IN = Specify flags which must not be modified.

Best,
Lancelot.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">  *
  *     Generic errors apply (see kfd_dbg_trap_operations).
  *     Return - 0 on SUCCESS.
@@ -1522,7 +1523,7 @@ struct
kfd_ioctl_dbg_trap_clear_node_address_watch_args {
  */
 struct kfd_ioctl_dbg_trap_set_flags_args {
      __u32 flags;
-     __u32 pad;
+     __u32 mask;
 };

 /**
--
2.34.1
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------g2ejjMYxD3kRJ4OgdCl65nmP--
