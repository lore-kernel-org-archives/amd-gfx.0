Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2CCEFB7F3
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 04:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28FBB10E4A1;
	Tue, 24 Feb 2026 04:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbKRBO6a";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97FA10E4AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 04:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyMTEZ4fITXPHql10uEFjm2UWhESp9pv4/66XGjA/6U64hxfCaVzKETsSk495pvzGWtdQ8JPm8dpHajZM53RidUFrWNbNw2qbNIjPMydgyfaNnHpcKEE7btMwimCfclJSeKwGYvjgoVya4RDLn56jNzQsiRoPXagDOi4AywLgAKb6XT18UzCOSvD/zPRDt0YTcQjYazH3CdDZuG38N5Clg1zMZKdCg++73Ynuf8hjEhXkGlKg8UTltkGh2yL0VUzIPIoYyCp4yO14MFVQ2mu1OEhUppRt9oDWjViqbZ7TXkk4gf8q1MLym5jvMZyzncEAjqyPpmAmPpisVMKC8uo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bvh8+cylJ3A4G4SS/ToDwuzhKniyE7SOmBr0MTfX4E=;
 b=uZLe24txWrGFR+mfhhZozYkjs4+kVf0xBr+eSFBlyAGppRpeb2tqoozec0IyQumylNy/vPb6wGoWu8JbM9FguYDWErZpewLqp7NvzOL0vQNZmhUI71cnEE7hYEU0vDBGSPKwR5N8v2WhzYspYPHOS1cGyBAql/e+I9KFCp82WvE7a+y7KpYP8gnHh9eIlk/lU4B3QFVlnDOamXwJmiCF0suCJZJfNWZ7tnfCpG3PJx9LBCqqHRXRmx30uUQWmrISQR0BmQizJmIK5lMPEA6HC1NP5xPS/LZQVkY9Jcu9JG8/YuDdcIkoVxz4qg1h23hey1CX7tqUVocZB5qxv7PyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bvh8+cylJ3A4G4SS/ToDwuzhKniyE7SOmBr0MTfX4E=;
 b=DbKRBO6aS4HQ/vmUVfurEmT73FxFPfoE/ekTwDQwQinQeEo7jRTz8M6OlMRd4Ma801zKOV9OMgpw5omStr8bhMuhaNBpbE9ed9fkJQOP852PX8H2uIMszG3XMKEkS/9rAAmpru8BItCmZ0CvT/tT0Alt+4+ENTow5+Fkb3yGQAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 04:17:09 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 04:17:08 +0000
Message-ID: <7ec86145-3a91-4446-b780-633be66424a3@amd.com>
Date: Tue, 24 Feb 2026 09:47:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] drm/amdgpu/userq: Use drm_gem_objects_lookup in
 amdgpu_userq_wait_ioctl
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>, kernel-dev@igalia.com
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
 <20260223124141.10641-6-tvrtko.ursulin@igalia.com>
 <0047be6b-9fd3-4424-8498-cb7aed30f38b@amd.com>
 <445d25ae-7c45-46ce-9de2-24c09711dfe8@igalia.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <445d25ae-7c45-46ce-9de2-24c09711dfe8@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::10) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf9d279-0282-4873-3c5d-08de735b9362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVhodmxpR3A3NGhRRWxTQk14cHpxUGZZSTVSbWlLKzdtTi9TSlo3eWJwd3JX?=
 =?utf-8?B?Z0kwMkNkWmhWSWJNOHAzRjFoR25VNmpHYlFpWmZ0VGVZSlVrUlBHbHUrc3g2?=
 =?utf-8?B?VFFwUTMwSW94ZFhRcmVmRVlFeTd3NTNXbVVCRWNEVkd3KzFVeURnTEFvMktG?=
 =?utf-8?B?ZEY0MTBRc2gwYkpFaHdpTzBVMTFDSlBZekhhTy84MHBlak9xbmU0a2hBZHF2?=
 =?utf-8?B?SXdEQlhUOUV2aHFVU3Z5dXJFNFJHSDRrbXgyUHFTYmZ6bmxPL3VPWllzM2kr?=
 =?utf-8?B?dkU3MW84QTNRT0tpOEprNkFONlU4dnViNHVFa0gzeUcrdEF2NFJSNllmdW9C?=
 =?utf-8?B?RGgvMnVxM2hyZnQ1N0h6MGxDYkltb0JheTdWVS9kak16Z3ExM3pqY2VZcjFH?=
 =?utf-8?B?d25BUDVUbWk0Sms5bDdHc1F2cStzbm5ET0R0dmNlaVkvYUYvVkxHYzhTNUNM?=
 =?utf-8?B?Z1daN3pIaFBsQVR1MUt0V3FXbU1Cb1RjTnM0a1U1SkZ2Nm9hL0tsTytWbTg0?=
 =?utf-8?B?c2VmcGpnSk5OV0dUOERBVTlUenhaSkJYZEhHbEd6ZG8rNFkrbHFNd3FYQnpQ?=
 =?utf-8?B?cTZpTjQwVlNES3dhVEhWOXlaWFNvWGF1b2tiOWhnVm5FcGFWMjRJRlo1bE5Z?=
 =?utf-8?B?OEg5OUI3N2ZjS3pCSTV6NTVONGpxUElXSzdneWFXRjY3aVBJQ3RWd2RuckRI?=
 =?utf-8?B?L0tXOC8wSmhKNWtNSHV6R1ZnV0crcHdIZXlIWVBsVHhvaXBQdWdUZld1c3lI?=
 =?utf-8?B?Z1l1RVZsclNtQllLK1FwT0RTbGVrYzBtN0xVQzI3Z0MxdTlVMi9veWQxeUox?=
 =?utf-8?B?WWdiOXdiT0ExcFpqOHp1RUZDUFYveHh6RGpNZXI0cENxOUhwOHo2djdsemdT?=
 =?utf-8?B?TUMrUWtxeVhrSktvYTZhWWZVNm11Uk5RR21EYmI5cWxrclVXNlVqSW5jUFkv?=
 =?utf-8?B?Q0JOV29RS2JaOVRBMXJCR3QwSExTSVQ3NXY4b05IQmdVTUE1RUhoWk9KTWhE?=
 =?utf-8?B?MmZvM1hseEVEelYwc0tiTGcxSjRNd3d4elZjMXNTZ0FOVDFGcDRQMGZWYlNR?=
 =?utf-8?B?TzZkMEhFdE93MHMveFdZS05GM3AvYkJ5YnBhT1ZCU1o0emFmT3hhSFZITmo3?=
 =?utf-8?B?SFoxRUJvR0VsS1NISklBcEVFUHg4alBVdXkreTZ3OG5qVkZ0YXdFeHozUGpS?=
 =?utf-8?B?UmZNR2t3WlFqaERPVnZpRkFjaU5zZkxmZXh1L0syWlhUamdHM0taaStaNG9U?=
 =?utf-8?B?dklUNi85bWVveE9DUlllOXFpYk9WRjArN2RNZkpRYkw5U24yK1gzRWF4Mngy?=
 =?utf-8?B?c0FRSDFNUkRCWkIydElIRnVhVHhBNzhIb0Y4ZHh3eWFIUVh1eTljQWhwYTlG?=
 =?utf-8?B?UTZodU0yRFFJMDB2REp6M3ZVR2lRNWFLbGo0ZmEvekFvUFcvL3l6b1pFZCtJ?=
 =?utf-8?B?L3V2a3FkUjB6V0lCUy84ZXd0dUhtb1F4QUVIQmxkSEY5d0EzSVZ6dzN4b2Rj?=
 =?utf-8?B?WjhaVDRqNVNPT1hTenlZYnBJYUpjNSsxeStHVFZzbzd4REJXWWNQRktDaysx?=
 =?utf-8?B?RGlVUFJXSXhJcENrNjkwZ3BHQnpuM2RvSFhUNTJyZ2Fuc1BNYVl6VW13TFl4?=
 =?utf-8?B?SksvRWkwNDNVRGNHQ05IOXhrT2JrRFdzdFI1TldabWxDWU5YVmlRRTRiQlZk?=
 =?utf-8?B?MzVheWdpK0t4UGYxUDljZXNmL1kxU2VMaVNoZTByUGJmNjZzbVp4S29GRFkx?=
 =?utf-8?B?WnhWTTU1VUlRcEJUdm1Gc2x3U2RJOThMVUFHYytsb0I2REhSd3VXQkRoeGhJ?=
 =?utf-8?B?SG1rRFhuUXhUNDJIeEJyM1ZHZ3k1TERiRXM2UjdkbURWR3ZuYlIyQmJpS1Fj?=
 =?utf-8?B?eUVhelhtbm5JdktYeFFlSGZZdVRUV29nTlVEaDFyc3gzN0pBNjc4ckZoMkZ2?=
 =?utf-8?B?YVF3OTdSUHppYWlxb1lpVkxDQnYvQnIveWY1bFN6Q2hqTjBHbW1YemMwR0Zz?=
 =?utf-8?B?OVJMQXlQV1RxeTdwUnJtNzdnaktmeEZueGtJd0tRQkdQVFZ0VDNTQUgzeVhm?=
 =?utf-8?B?VU4vT3drLzJ3amVGSW5PRkFMSXd0c1BjQjEwNUxWc0M4cnI2RWtWbTlJQVBX?=
 =?utf-8?Q?NgRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUlKakdJTnFtVmswekswNDB0SWtjNlRZc1FhK3lyMDNYRnl3ZHpyTDVCWDhG?=
 =?utf-8?B?QXliWThxT2Jva3BJMHhGYW90aXV3NG1xTHZkeTFLNm15RGJnZGREUk1JaWE1?=
 =?utf-8?B?ckRPcTY4NithZXY2ZElmSUR0V3ZNKzFJV3F4dk1pL2xIa1h4Q2xvOCs1aW1D?=
 =?utf-8?B?SkhhZmYvU3FHVHRMQitEYmxaRmhabjA2eC9JQ1RMdjI1OHBWY2QyRmpTT2JT?=
 =?utf-8?B?TjFOMDFnQ1NCQzFuVi9pczczbG5FdVNkSk9FZThLejRDTG9TLzRDdHJsTHkz?=
 =?utf-8?B?OHVvWHUrN0MybW4wMUh1N0g1ckl2eHFySEFRSDRxNHg3N3RZam9VU3B5c2Zq?=
 =?utf-8?B?Um00Y1NUUVRKNWpaaTZ5cUlTcFg0T1l5UDB1UUhRdjJuYUhOVThzS0JHT3kz?=
 =?utf-8?B?UkRReXptY2JjTk1BTTRLdHM0Q3Z3WjFvcjV1YmplM2o4Z05TY2ZrVEdxV3pK?=
 =?utf-8?B?ZjdpdGR4RUs1NlRDL25HUmZqZk1YbWNsakVkV2U5TkFzT2JCNWcxK2VaQktG?=
 =?utf-8?B?SG1DUzIxZjROL1dUTTZnaTMzbjh0L1Q2c2VNM2xqNTdBS3QvQXN5bnFuYTBs?=
 =?utf-8?B?MFpTZUgwZStpdXRKMnFpT1VtZ2M2dStjbTZTdjRNbDhXVk9zUTQzR285QjUr?=
 =?utf-8?B?d0dxL1JXME9Cc1F5aWpUdUJLQzk4cnFJM2J5US9SdEk3U2J6cEMzdm9ub05U?=
 =?utf-8?B?c0tRRThwN3VjT2dOOGJiTDd1djRRRzZJR3d3TEowK21VdmxXVmJWZmNqcGhr?=
 =?utf-8?B?ZEE3OG9MNEwzbWRxczAra2ZLWnZKMEVUNGFOQUdEeE5YMjlKVmdYRjhoa2tV?=
 =?utf-8?B?ZFdacmpUeDJwZEEvLzhId1RjK1ZyQytNVHowVG9rcFJ4YmJ5Tk1oUnFrVnRS?=
 =?utf-8?B?Kzd2UlhoY1N2bXc1SnVGZTJpMkV0Mko2NWhuUmlqbjR1TjdEVU93TGh4QTZM?=
 =?utf-8?B?MWhGeEh0U2JXbURCWElTUmU2cUI0ZWR4MjE2NU5Yam5VdWMvWGxwd0VaRGRU?=
 =?utf-8?B?OThhaG15V1IrM0gzNzZ0Q0hsWDdQQXNvRHhsbkhXYWxvSU4vbXB5alpldzI3?=
 =?utf-8?B?dVp4Sk50RXNydUxPa0dTeFBFSHR3R0xBeG8rSEFFcGpqejBCN05UTEpNTDdn?=
 =?utf-8?B?QUkyeEJMbGE5U1hLMUV0NmxDLzFpQ1FMZnlsZVhnUlZmNXFuZXJrTXppOFlo?=
 =?utf-8?B?R2VZckdhUG5vQnFXbkZLdEdGNVNVT3NuQnJMMXpEU1NVMitaZTV1WUdWY2Qz?=
 =?utf-8?B?ZFpGYVpOTzNvczhJUUNYRE9EeEZMNnVZMjQrajJBeEg1SjRZWnNEeVVHSm40?=
 =?utf-8?B?bVBuZ245Vm9tQW9hZ0lFMlJIOVJNL2lFL3pTYmpPMHQvbUVsQjFMM1VYRHZn?=
 =?utf-8?B?bmJYd0tGMzNLeDFvVUg0R1lqRVF4QzkzRGxMbEE4WDlIM2I2OXBQSWZ6azFw?=
 =?utf-8?B?dDcraW50SHJCYkl3RFBoWEJRTkVqakU0SURxeXdaYWtDNUZOS1JSeGZqbmNy?=
 =?utf-8?B?VTNZc2xiL2toWVZjZ3FKYXpYcE9BWDh0NkJWUHZ5S1JJYno2b1VFT2ZiNHdD?=
 =?utf-8?B?aTZ6M2U3OFI3ditSSXpDQkVrZndxcGlQblhBRjd2a1ArQ04yRU52bTBxNmVx?=
 =?utf-8?B?WEtZQ240L1NGd0xXejNQaGRtZWIyelRrR1A5ZDk5bkdXbHdZWm9YRUtBT0Ry?=
 =?utf-8?B?VWh2R0tjclRkT0M5Z0xvbjVWdWhIVmFWT0QwWStLMC90WVBaT0NjRnFBTnVw?=
 =?utf-8?B?NEI1Y3R2RkwyMFI5bC90bFFMQ3B0dEZKcWRSaFFWK3doWFBDK2FLWnhXVmJR?=
 =?utf-8?B?eUVEQmxEZXdqZGhVMU84OGhWN1l1dFJYMGNFcEJ2NXZFdFFsTm1Sb0V0SnFF?=
 =?utf-8?B?WjVFbDM4OFhHNDlHSzl2R1BZK1EwV2dWOHRMdjdZSFZxaldIWXhqRFljdFlD?=
 =?utf-8?B?ZnRNamQxVDl3dkFyLzMwb1lWa2RWQmI0c00vS29mOHdsZ1dHVkRlUlVvUzFR?=
 =?utf-8?B?ZFpTTjRwVStqeE9rUUlnR2Y2amlINGlwVDIyN3hwWFhodWFSaW5JNGdEdU5a?=
 =?utf-8?B?Qk1SanFZRXBkeTlRT2JEdGZSVjF2bWR1S1VtajRXbGowVnlJM3B4dmQrRjRu?=
 =?utf-8?B?azVCUUZ6aVVvWUJ6eGhNOGZkZkZqZFluVUxtc3M5TkJGWmlHcHJEdVdFcXI0?=
 =?utf-8?B?UG4xUEk2QWFtNFc5Y1kwK2taSVV3bmJkdUdhUUtSemNDWnJVai9CQkVTcTNp?=
 =?utf-8?B?VmMyalp0Nnd5ZWJpd2daTDY1YUE3Tm9ZTmN4dFJqc2FId0s2eDNBUXkvQ2Vw?=
 =?utf-8?B?NHdGRjBxQ0NIazU1UnFDVldLSHFWV1diS2RCMEo5ZTNwOVpxeXlvdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf9d279-0282-4873-3c5d-08de735b9362
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 04:17:08.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzDuZ8D6Ck+uS6PBszplE/ZlCtT0ZUbUfAm0E1EpXaEGM0ZM7aCCtKoR46xqJe1U5HB8T/1Al6RVTjC0ptgEkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 23-02-2026 07:37 pm, Tvrtko Ursulin wrote:
>
> On 23/02/2026 13:58, Khatri, Sunil wrote:
>>
>> On 23-02-2026 06:11 pm, Tvrtko Ursulin wrote:
>>> Use the existing helper instead of open coding it
>>>
>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 79 
>>> ++++++-------------
>>>   1 file changed, 23 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index ee6f03f75b41..d779671bd0db 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -610,44 +610,29 @@ int amdgpu_userq_signal_ioctl(struct 
>>> drm_device *dev, void *data,
>>>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>                   struct drm_file *filp)
>>>   {
>>> -    u32 *syncobj_handles, *timeline_points, *timeline_handles, 
>>> *bo_handles_read, *bo_handles_write;
>>> -    u32 num_syncobj, num_read_bo_handles, num_write_bo_handles;
>>> -    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>>       struct drm_amdgpu_userq_wait *wait_info = data;
>>> +    const unsigned int num_write_bo_handles = wait_info- 
>>> >num_bo_write_handles;
>>> +    const unsigned int num_read_bo_handles = wait_info- 
>>> >num_bo_read_handles;
>>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>>       struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>> +    struct drm_gem_object **gobj_write, **gobj_read;
>>> +    u32 *timeline_points, *timeline_handles;
>>>       struct amdgpu_usermode_queue *waitq;
>>> -    struct drm_gem_object **gobj_write;
>>> -    struct drm_gem_object **gobj_read;
>>> +    u32 *syncobj_handles, num_syncobj;
>>>       struct dma_fence **fences = NULL;
>>>       u16 num_points, num_fences = 0;
>>> -    int r, i, rentry, wentry, cnt;
>>>       struct drm_exec exec;
>>> +    int r, i, cnt;
>>>       if (!amdgpu_userq_enabled(dev))
>>>           return -ENOTSUPP;
>>> -    num_read_bo_handles = wait_info->num_bo_read_handles;
>>> -    bo_handles_read = memdup_user(u64_to_user_ptr(wait_info- 
>>> >bo_read_handles),
>>> -                      size_mul(sizeof(u32), num_read_bo_handles));
>>> -    if (IS_ERR(bo_handles_read))
>>> -        return PTR_ERR(bo_handles_read);
>>> -
>>> -    num_write_bo_handles = wait_info->num_bo_write_handles;
>>> -    bo_handles_write = memdup_user(u64_to_user_ptr(wait_info- 
>>> >bo_write_handles),
>>> -                       size_mul(sizeof(u32), num_write_bo_handles));
>>> -    if (IS_ERR(bo_handles_write)) {
>>> -        r = PTR_ERR(bo_handles_write);
>>> -        goto free_bo_handles_read;
>>> -    }
>>> -
>>>       num_syncobj = wait_info->num_syncobj_handles;
>>>       syncobj_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>> >syncobj_handles),
>>>                         size_mul(sizeof(u32), num_syncobj));
>>> -    if (IS_ERR(syncobj_handles)) {
>>> -        r = PTR_ERR(syncobj_handles);
>>> -        goto free_bo_handles_write;
>>> -    }
>>> +    if (IS_ERR(syncobj_handles))
>>> +        return PTR_ERR(syncobj_handles);
>>>       num_points = wait_info->num_syncobj_timeline_handles;
>>>       timeline_handles = memdup_user(u64_to_user_ptr(wait_info- 
>>> >syncobj_timeline_handles),
>>> @@ -664,33 +649,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           goto free_timeline_handles;
>>>       }
>>> -    gobj_read = kmalloc_array(num_read_bo_handles, 
>>> sizeof(*gobj_read), GFP_KERNEL);
>>> -    if (!gobj_read) {
>>> -        r = -ENOMEM;
>>> +    r = drm_gem_objects_lookup(filp,
>>> + u64_to_user_ptr(wait_info->bo_read_handles),
>>> +                   num_read_bo_handles,
>>> +                   &gobj_read);
>>
>> If i am not wrong even using the helper function will not avoid an 
>> OOM situation in case num_read_bo_handles is a very big number? This 
>> is just using the helper to reorganize the code but not having 
>> additonal checks... and alos valid only on drm gem objects type...
>
> Last part about only DRM GEM object type I did not understand. It is 
> currently using drm_gem_object_lookup so that is the same.
>
> Otherwise yes, although my understanding of the overall topic was you 
> will apply the limits on top of the consolidation patches.
>
> Regards,
>
> Tvrtko
>
>>> +    if (r)
>>>           goto free_timeline_points;
>>> -    }
>>> -    for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
>>> -        gobj_read[rentry] = drm_gem_object_lookup(filp, 
>>> bo_handles_read[rentry]);
>>> -        if (!gobj_read[rentry]) {
>>> -            r = -ENOENT;
>>> -            goto put_gobj_read;
>>> -        }
>>> -    }
>>> -
>>> -    gobj_write = kmalloc_array(num_write_bo_handles, 
>>> sizeof(*gobj_write), GFP_KERNEL);
>>> -    if (!gobj_write) {
>>> -        r = -ENOMEM;
>>> +    r = drm_gem_objects_lookup(filp,
>>> + u64_to_user_ptr(wait_info->bo_write_handles),
>>> +                   num_write_bo_handles,
>>> +                   &gobj_write);
>>> +    if (r)
>>>           goto put_gobj_read;
>>> -    }
>>> -
>>> -    for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
>>> -        gobj_write[wentry] = drm_gem_object_lookup(filp, 
>>> bo_handles_write[wentry]);
>>> -        if (!gobj_write[wentry]) {
>>> -            r = -ENOENT;
>>> -            goto put_gobj_write;
>>> -        }
>>> -    }
>>>       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>>>                 (num_read_bo_handles + num_write_bo_handles));
>>> @@ -947,12 +918,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>   exec_fini:
>>>       drm_exec_fini(&exec);
>>>   put_gobj_write:
>>> -    while (wentry-- > 0)
>>> -        drm_gem_object_put(gobj_write[wentry]);
>>> +    for (i = 0; i < num_write_bo_handles; i++)
>>> +        drm_gem_object_put(gobj_write[i]);
>>>       kfree(gobj_write);
>>>   put_gobj_read:
>>> -    while (rentry-- > 0)
>>> -        drm_gem_object_put(gobj_read[rentry]);
>>> +    for (i = 0; i < num_read_bo_handles; i++)
>>> +        drm_gem_object_put(gobj_read[i]);;
>>>       kfree(gobj_read);
>>>   free_timeline_points:
>>>       kfree(timeline_points);
>>> @@ -960,10 +931,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       kfree(timeline_handles);
>>>   free_syncobj_handles:
>>>       kfree(syncobj_handles);
>>> -free_bo_handles_write:
>>> -    kfree(bo_handles_write);
>>> -free_bo_handles_read:
>>> -    kfree(bo_handles_read);
>>>       return r;
>>>   }
>
