Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E509EC1EAC
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 12:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF3610E87F;
	Thu,  5 Feb 2026 12:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JNONDbcE";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9619610E87F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 12:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pifwIO+bROLVut/XrvpjBSoZle2hyConDDWHkf4qf15eNByoMbWt2ErcAP2asFc9+wNQ10dWjENQUbBO38EUX3nQ2jumbHOCvVjeBJSFOBw4sY+03Ls3ErQzPsymCpG4jHabURcQLqe3vkQiZMR0gpdxfof6U47tvggqhSazHESauZ6K227KboIaCEzmfFProb8pv1RPLVhkOpbIh+q7C11kpRkqArhctFKMnu+qN+GJMnidzN2h8Y2bkckXfK98rQQkV0OWY8A0U4N5yIf5WDLSGKGRpnyG8eqFM/6aw2UKR0Dd8r1X05tjLLyeqGb+cyTq6Hrkim0+T6nmRhqzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pd6b/kbgmUuXrIZY9naO+iXVVYMTwGR+G6zBMvUQRx8=;
 b=DJ2YXBM0VVxndrPTvUwm0FfTLPGYP7E4149f2R3NQYeu7i3vLh8EB2mx6DOtW9CPVFzURZao4Kxthsm5HttrltnWAWrHM+VSj7VZyf0Ty3KaNWk4REEnR+gBI68yWFKiquGOKgngnmPYGtgzA0fG6euhr76+GY9YFZ59ljIM8Mf7nX47Xat+mRmaLGCxwQfNebY0C7k26kUk4HuC4wzJQOtFdIlbqYmfhK3798QztCVrGLInIwx/dpDi+0FVseSvtNiAZ2zNnhudI3GFwPZHlWWSUGif0utwfLY6URCAsBukG/HThJmh9jwb4/nRlIHho9jaZWCy8NmPdsMGBNUurQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd6b/kbgmUuXrIZY9naO+iXVVYMTwGR+G6zBMvUQRx8=;
 b=JNONDbcEK+Kv1/VzCJM0eZfHDfSWsvluYZ3+OYxCQqjX4sfh29mIVghh1Ynpf2VNEdBsueaYE5IErOk2SHgPHXRT38iSHV/IaiteGiQQbavxLagGXq3YAGB5vAHnSxpKzc8HBPxloMC+3vkCfrwIMGhdVytzVoo4JH2AAzUDhqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 12:29:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 12:29:13 +0000
Message-ID: <8d1b948b-d7b3-440f-a316-a74bb82c338e@amd.com>
Date: Thu, 5 Feb 2026 13:29:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
References: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260205121307.285864-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee4e743-bccb-44c2-63e6-08de64b22b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEMzaFlBSFBTWmd0VEY0dVhKSkgzSm9XUS9hZGx2RlZSTXhmQm5tYS9kaGhj?=
 =?utf-8?B?WEpoRjhRL3g1aFc0dER4YnZPdkdEbG1tUHZHaEoyOEFKMDcxRUU0bHBYbC9L?=
 =?utf-8?B?bElQTlNnT044WXB3UGdDRkltVkpTZnhGM2hKelQySExZcWdqTTc0Q0V4MUxW?=
 =?utf-8?B?OTMxcFQ2dVlDVVpmeXd6Vi9iNDQzVFBiUVJvOW5KQWdOd01jczFDZFRzTGxr?=
 =?utf-8?B?aXpkS21zUnFseis3VGVjZGh3YjRzbnhsN09NelNJMFEzSXo5K2xEOGkxSjBS?=
 =?utf-8?B?OVJ3alJMM0FjdThnamFhRG5pMEIyYXpNZmFZVkNEZUUvZy9DQlBjU3dQQ2VU?=
 =?utf-8?B?MlMvRmtIeHdoNlJkaDZobGp4Q21vK2xZdHhBaU03N0RmNHRXVi9ZUndwYjhD?=
 =?utf-8?B?R3V3YWdYZ2g1RFQ3ZjdJZXV4SzE1ajhVbTNQdVlyUVR6a1Vxd0tnb2NuVGZF?=
 =?utf-8?B?WDV0N25LZ2czd3JkQWNjWTdaNWxMRHV2eU9OdUsxSjhSTTdRWkdiSVRBZitO?=
 =?utf-8?B?R3M0RHJyTEpsUU9MRmplMzU1SkJFamUzNWt1YzdkQ0RqcTkvaGpBZlJMSmhX?=
 =?utf-8?B?Q0VXM2lHN2x3OVV5QTBLU0YvS05LcGphTGh2NEwwSXFRSDdWaVZ4c1lEdGpW?=
 =?utf-8?B?Zm1IMVNFOUpZVmRGZTRFcmc3UkZZbGFmaGkzUFArSXJtMWNZT3I2Q3NpS3RT?=
 =?utf-8?B?Q0tSWE0rTXd0d0p6NWtsZ1ZWMitJVUZiWEtVVFJ3Q1JkQXNlZTg4NTVMYmg1?=
 =?utf-8?B?ZkdZeVlSSlVQMzFSNU0yd3FNZEJqTXVKNkUvbklUZTlUYlJjenJkd0pZWmND?=
 =?utf-8?B?cUxOV0J1TzQyQzFTck1OUTBnVEtBckMyWmtPQWJZY093b3Bha0Q1S1hPOUR2?=
 =?utf-8?B?ZStlNzFmbUFzKzFXSlNkN0RMeVJNVk1ROTdJT21YaGVROXc4NFhMKzNZcFl4?=
 =?utf-8?B?Tms2bTB3VlRLRkFqV0RIckpWK2QwRTFiUktnTUNwL28rOEZZYmtVcHYxYU15?=
 =?utf-8?B?TUdjVklsQk9lMVNLL3E1c0tCL1Y5SDd5VVFmaHI4NDl0eEhwUkV3RW5GN2RD?=
 =?utf-8?B?bzh3NDJuUWRGUVBIMEZBSmpjT0UxcFFPSnF4N1VnVWhnUjVUV1lvY3krcVhv?=
 =?utf-8?B?UVVoRFJBV1p3U0VXcWducVpuSmNsUUpMMSt6OUJGeVU1MkV6OFk4aVVLSkFt?=
 =?utf-8?B?eWNONmJueC9ZM0FNalpsWkpVN3h0RklYd3dJNFNvaHFpdStIaDNZYW5tYzhL?=
 =?utf-8?B?QXNEbDJDb0QvTWVCQkVIM3JGREtkdUtxWjVydEtuNWZ5OFFLU0ROdnBTeHNP?=
 =?utf-8?B?L0YwVDhVaktyV0Qva2JxcHlJSzVjTFRZZmIzN21HbVFRUUUydlhtNFJSeUJx?=
 =?utf-8?B?L3p2SXE4bGxmeGxxQWFSeThaUlhzcHFCYzdyd05kays0Sk1vUlp0U05BY09n?=
 =?utf-8?B?cW1BRlJEb3VVOHNIdUpVeEZmZGF3YXdPVXgxWW9yR21paHZKL255dU1xVWk1?=
 =?utf-8?B?Y0VRRFcxQnl2cUVqSGQ0ZVNGUjB2VExzWDE3NjlveEc1YTFyQUlCWXRWcHgx?=
 =?utf-8?B?UHhsMGs1bmJrNjNxM2VjNWxRN0thNm9kWWhDblJuYzJ2czFiSmtIWC9iQSsw?=
 =?utf-8?B?MEVpUWpSbzBXRkpTLzRZVk40NTFoTFNDdjZNVkloaWMrN1h4Z2dQUmVJa1F2?=
 =?utf-8?B?eTdsc1NaRFRCZlhIZWFjRkh6WFdXbG1CYlBYOFc1UHNYOHNEeDB3Y3BheTVz?=
 =?utf-8?B?TDRlS3JIOXU0eW55SjZlNGlzSkpBM21JeWRCSzVtakUvdDUySG1kemdXdGxn?=
 =?utf-8?B?TDR2Rzh5Y01sQmVRZXlLdmNqWmM2TzBPVjcwcmRFc0tRa2FOdGJTeEJ4SFV1?=
 =?utf-8?B?UzhkRlNob1VaVmlYY2VFMUxiNFFnb01pZUpHQXZjOW1XZFlYcS82dlhjT0xQ?=
 =?utf-8?B?SHRmMWdyYi9WZno0OFB1YW1XQU9lbXZqTWtyQjNSbi82dHNrTFlUQU1vUG8r?=
 =?utf-8?B?QUdvOUdjV255V0M1Z3ZESkRENGVlblRSVWt1SS9oZG54a25UODdjVDNOUEp5?=
 =?utf-8?B?V1hGUUhwSHJNekVXSFk0YndKUnFpYWpKTWk5THkvd3gyZGx5a3Nnam1ZLzd0?=
 =?utf-8?Q?CWZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck54TXpxWGc0MkU0RVdVci9HQ1NkaFl5UTVQdG53TVJDRG1BbEh3M096NWFq?=
 =?utf-8?B?N2UrZk9WVWVpTnhFZHV5MHdnTmEyVHlJa3JwSFowWkIwYnRYWGRtemNPWG4x?=
 =?utf-8?B?M3ZyWGlxUzVZSHp3bnlZRWNHbDl1U2RhN1oweDJOSkxWOUpLS3czaHptMkZ4?=
 =?utf-8?B?K3FxVXJFMlBXazZ3NTlLc1FKU0E4NlpzcjFUVTM0Q0dJM0pJeDVRNHNGN3RW?=
 =?utf-8?B?dHJEdEVOOWZVaUgwYnFZdnU0Q3dNUW1MWGF4Y0tHWWpBN3hXTDhNbnBQSFBw?=
 =?utf-8?B?TTRCckhWV2FiTFMrTlJVNjF6cnQvWXBzVWlQQmpsU25YZTcwREZiL0RZNlYy?=
 =?utf-8?B?dFBtb3Mwd1dHeEUzQVIvTEF1bllZakFPcGV5a0hMOENlbGlDeitQMWkralVU?=
 =?utf-8?B?TXNkeUs5Z2xUYStSNithTm04UUl6Zi9uRFNUakxLM295UzBWaS9IL1JaNldi?=
 =?utf-8?B?RFJucE5nS011L05tMGF6UzRZMWhYdHIxZWJyT0pSZThjcmUrWjFSNHdqbDRD?=
 =?utf-8?B?ZCs1V3FsL1NZY05QZnNvWWI1eW9EZWh6T2tYY0tFTEdDbm8xUXoyV0R2MnJ0?=
 =?utf-8?B?VDdydWxrT0RjSE92S3NVbTd6YUdBL1pSZlBWOHVWTHYwZnY2K3F5cm1JaGFp?=
 =?utf-8?B?RWxLdzdFNk1pOE1mUzY1QXdBWjNrSnVGMFIyVkNOWCs0aE5lZUhDcGFJdWx2?=
 =?utf-8?B?U3FrYzhGdmVyUEYrb201NDdRY2FBeGdONXVsVnlNd3dXUmo0NHRoaEJNWWVZ?=
 =?utf-8?B?WjNEelZPNlR6a1RaV2pCNjVsTDE2VncyNUEwWDM2MitCU3VGbEVYVnFvTjVD?=
 =?utf-8?B?cTlqbDVJeDA5bkdWSUtGL0ErMHhkK0Z5dE5McmhxcTE1Mlo3QkU0SGVpdVlk?=
 =?utf-8?B?c0RaTFdJc21WUURMeHpDejN6dmxBcjM5eWhaNDRFRXlSeU1WeDl2ZmNESHFU?=
 =?utf-8?B?aFZLNXdKV1ZzZFE2eVhDVnVHYWhjTnRnd2dRQlFrcUljL21IQklRRjdBZDNo?=
 =?utf-8?B?SnR6b3hiVFdPYitUMXVWZVVjU29ubE9OWm53ZGd6L0N1L1hVRjZWMEZlNjVV?=
 =?utf-8?B?cmh2bkZqREtJYk5pdCtkU0NKZXBhUGtKN0VEakdoNU1EYVU0NVM3Y3Jnek1n?=
 =?utf-8?B?dXZzdEIramZhRkxyOEgxRjZWRE5PejFaR0dqNTVHanRDTzhoUWxONDlNSGgr?=
 =?utf-8?B?dlhPa1lPVDFsRGtxWEpDTlg4U1c0Sk1UR2lzNVpmVGdkSE9BLzhiZzdwNFFq?=
 =?utf-8?B?ZUdtbnhlK2ZYVVY4b2U4NEloS2hxVzZIMHB2QUxhZWNqTUpkYTFWR01aSUR2?=
 =?utf-8?B?aEhrdW1GeFVhcmN6aDJsZHhOZXpFV2gzVWFNYVdHL3YrbjFkZnRhWENnWnBk?=
 =?utf-8?B?Qm1lZGszOHJld0FWczRRZ0NLUzZIVzdhemVqQzhJejg3eWxiV21PRnB5b09S?=
 =?utf-8?B?S3FOVFhTWGVSbUthWjRrRUZWOEh0U2d4MkZKWCtUa1RET1NkQ0lFQnMwRnpR?=
 =?utf-8?B?OHdqSkRyc1hCa3RWQzBPNXNxL2FwcXFRakExWjZIaU5RWXdjb3UyVkdmMFU1?=
 =?utf-8?B?L2ZHWjRrYW9OVTVuZUkrUmdaR282SFR0WEpjeHVwZlR5SllzclYwd1RBd2RD?=
 =?utf-8?B?K3hOOTVMcmdxRWd2WEcxbHJOTHdZckhpUVRSWDluMnJZZlk4OEorQXRYaUdS?=
 =?utf-8?B?aXZ1UUVDWFc0U2FiUWdsZUdsaDkrb2M0aTVZSndtSkJXbk1veGdrM3RveFJB?=
 =?utf-8?B?RUdQQ2JadTM3bXBhWmNvT2ozSzRoSC8rK2lVaWFPRVZVZ1JwNnBiNStLQVk2?=
 =?utf-8?B?ODZuL1J0OEd5NFJacHVpdm1Tckp0dXlJV2RBemd0clpybUIzVmV4ZmRVUU5w?=
 =?utf-8?B?VTd5UDdwSk9JYzFLVkd5NWUyVUhTRmFGQ1UrZWNRZ1B4RTlaWnFIem9STklX?=
 =?utf-8?B?SmZtY2dvdzduSTMxN1NnM1FUTFRlOEs5dDZlT2F4SWtRVFE3RVhtUHRza0pH?=
 =?utf-8?B?MlRrdndXcVlYQnVId2k2OHYyajI5VER4aXZzRXJ4NEpadlR3L1E0V2dNZnBD?=
 =?utf-8?B?VzZxaVF2blMvU1FUcFJ3SjAyZ2RNRGRKbmJ0eVgwWDRQQWVGencyWnFTUnIw?=
 =?utf-8?B?TjJZLy83RitZVytkc05WV0ZZU3Q0OTZiNVYyVXpXOEtBbFlGemNoZitHOHVt?=
 =?utf-8?B?YXMvaWIxV21uTEJKa3FYNjA3M0pHK1NMM3phNC9HVTZ1ZXU2WnZqZVRuZWFs?=
 =?utf-8?B?SmVCS0ppZC9KS2pzbWpmNm9teWlLUDhEeWFqdEFDb09YYWs5NHFwVkNxVUFi?=
 =?utf-8?Q?uitSnPKHNDeojWtmKq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee4e743-bccb-44c2-63e6-08de64b22b67
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:29:13.1214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W34hCuOX3xFkgifW/YPeTdVHeRPRAbcask8620VMEVnTMZqhT6jz/sry3qG28ErH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738
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

On 2/5/26 13:13, Srinivasan Shanmugam wrote:
> drm_gem_objects_lookup() can allocate the output array and take
> references on GEM objects before it fails.
> 
> If an error happens part-way through, callers previously had to clean up
> partially created results themselves. This relied on subtle and
> undocumented behavior and was easy to get wrong.
> 
> Make drm_gem_objects_lookup() clean up on failure. The function now
> drops any references it already took, frees the array, and sets
> *objs_out to NULL before returning an error.
> 
> On success, behavior is unchanged. Existing callers remain correct and
> their error cleanup paths simply do nothing when *objs_out is NULL.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a1a9c828938b..862c9b2b9c0c 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -775,19 +775,21 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>   * For a single handle lookup, use drm_gem_object_lookup().
>   *
>   * Returns:
> - * @objs filled in with GEM object pointers. Returned GEM objects need to be
> - * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> - * failure. 0 is returned on success.
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop the references with
> + * drm_gem_object_put() and free the array with kvfree().
>   *
> + * On failure, *@objs_out is set to NULL and no further action is required.
>   */
>  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  			   int count, struct drm_gem_object ***objs_out)
>  {
>  	struct drm_device *dev = filp->minor->dev;
>  	struct drm_gem_object **objs;
> -	u32 *handles;
> -	int ret;
> +	u32 *handles = NULL;
> +	int ret, i;
>  
> +	*objs_out = NULL;
>  	if (!count)
>  		return 0;
>  
> @@ -796,25 +798,34 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  	if (!objs)
>  		return -ENOMEM;
>  
> -	*objs_out = objs;
> -
>  	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
>  	if (!handles) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_put_free;
>  	}
>  
>  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>  		ret = -EFAULT;
>  		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
> -		goto out;
> +		goto err_put_free;
>  	}
>  
>  	ret = objects_lookup(filp, handles, count, objs);
> -out:
> +	if (ret)
> +		goto err_put_free;
> +
>  	kvfree(handles);
> -	return ret;
> +	*objs_out = objs;
> +	return 0;
> +
> +err_put_free:
> +	kvfree(handles);
> +
> +	for (i = 0; i < count; i++)
> +		drm_gem_object_put(objs[i]);

This here works only because the objs array is allocated with __GFP_ZERO and drm_gem_object_put() can deal with NULL pointers.

That not obvious at all and it would be nice if we could avoid using __GFP_ZERO as well.

So I think we should just add proper error handling to objects_lookup(), so that the function drops the references from already looked up objects again if something went wrong. Just keep in mind that this needs to be outside of the lock protected area.

Regards,
Christian.

>  
> +	kvfree(objs);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_gem_objects_lookup);
>  

