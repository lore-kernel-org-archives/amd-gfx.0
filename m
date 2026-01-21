Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CD1D262B0
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 06:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7ED310E6BD;
	Wed, 21 Jan 2026 06:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V6a5gJgs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC4010E6BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 06:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPacnVBsL6bbpbzoJipNUWsc6bVMEfJPm/zIeUmdfnb5qxgGAisy9RnvVPKjBr0NpANJB8f1pzvM7aEk2QBp91Rf86y8YcPj11NNFSxyOO0RGnPQR185XtlxUsolWTwDlCeybyWEw+J/JujZyGN1Rf+4yzUYRfqOMbW++trTfiv378AXyZZCtlNBPLXope1a04GLvd9tiVj6fFu7INfPjPEgNjkCFpvjOcR5X+GfsV2E5AaGuw1TokHjaLSe6qhWGRJYlI2n8hK+nMRJTEWfpiSIXaxxSuKtmbShPh1mtxwuIA59z27R3W8mBfv2MBNsxdJlkPK+VOcp598oAkm1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ysmi0ys/vneX1+pRML9JfhkOswJU1VnPPXkqi2khjeA=;
 b=WM5RflgBQIBUGLvcEKZbvxAOY0iGYBiZgqXmdsnMyD1cUaZ305ZpH1pzJ9a148NEVgL+YBh/R0U9Fgo7O/t3D54t9OTacS0xpOALkdXgCezbjA2T22dJ36d3uByRSnwIlF9SK7+lg73p+q8oH8adwMlR2g1uWX/bhd4NEV+Iyo/MZWak+rJr+nWmhG5yje+eWNHs32c8nQllnNQ4sKJEWyfSI4pH4LgjUd2E4Lno0Nxuxm20sP0f7NmJlFpbDxxLf2LkWwZ9LQ6PXrfsF+Y3oW5PN23i3+cPNHM5TuDxgjs4db/XQ5wFVk0aWyoDBtuH6Z1h7dxSHRgkgGf4RPDzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ysmi0ys/vneX1+pRML9JfhkOswJU1VnPPXkqi2khjeA=;
 b=V6a5gJgsaErshh883iECBvfPqvmFjjgd7y6GWvNVeLJMs3d/5FLvvmHhtRzk/NtYgxVIv4HeLwFwpN/x5/Rq7FuT4JMrY6a1d0dok7ghxchbuhZ/X/rsnnxBLvOHEVHUsOyWte0jr0swVFQrQqKc+v7xFw3cEY32/1n5pxa4LqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:07:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:07:57 +0000
Message-ID: <52edd16f-a1ee-433b-b524-adf8c1164e57@amd.com>
Date: Wed, 21 Jan 2026 11:37:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting
 issue
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com, kenneth.feng@amd.com
References: <20260121031422.3431903-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260121031422.3431903-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 051bd260-8a5f-4908-26f9-08de58b36bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0NSbGNkczRtdGFTQ2ZBVGEzQ3lqMDl1cWZtUkZhUUdWMUFxcjNrS3dEejNp?=
 =?utf-8?B?TUgvU3cyeDN1UDRINVRSbHhvQ3JrUFB5VXVXODl2TThyMlRaMG9mdTZDWnN6?=
 =?utf-8?B?bjVvVnRLVG5ic2tXa2NscXlVQmk0akYwU3NtVys5U0lIR2IwcWZoLzF1R0h0?=
 =?utf-8?B?RkdSczVWWVlMZlBIUjY0clRHSzVmQk5PSFB6ZFNDVVFrUjFnaFdCb2czNXIy?=
 =?utf-8?B?WHcrL2Y1MjRiNEF4QUVCWmlSL1RPdkFvblhxUEJaKzA3RHJDRUdZcldmdjlI?=
 =?utf-8?B?dnhidHBRTzdKd2hVUHpmcGFNYk9OTlZKMmNIL1B0UDgrYUZIcDRERFM1REFL?=
 =?utf-8?B?MXpCU3BWK2g1RzJyOWJOS01KRGJCa2VoVjZkSmwrWG8rN0xNV2xodFAxM0sv?=
 =?utf-8?B?dnFXcSsrNkVxc3ZteGlESk50VUxlelh3My83VkxsRHcvSEpqbUh6aFVmd2FH?=
 =?utf-8?B?N09OV3AzSkN0MzdBWnE3ckd3bHJReldZQU9mbWVQMVVSZzdqSXMwblF4U1Vm?=
 =?utf-8?B?Ri9VRGF3aDl0K2hVbjkvT0xHWDJMbmpEZ3puWGJtVGJyT01vVXZDVHlGRFZU?=
 =?utf-8?B?WGZKRWQrV3d5a2pIQUhURFRud05kVTJJWlpnTis5TnZYN3pldlFua0dvZmxo?=
 =?utf-8?B?UTBLZmp2UVc5bjFzRTZ1aWJOTjhiTHQ2Wm44WHJsMHRMM3VWamRjdm9pK3pU?=
 =?utf-8?B?dm1rVFhBZERpdjZQem9GakNZMlpUbjlncFdGQmlzL1JoWVdzVldaWjJHNWtV?=
 =?utf-8?B?SCtKODFKT05CRS9hbFRhVCtUZUtmOERWZ2FzUWsyMEJFdVRQREliWU5CWFNH?=
 =?utf-8?B?cmZzV240eGNkaEt3b2lVYUJsalJ6ZGMraWZEWmo1YVhrVWllSVhSSWRZeVJ0?=
 =?utf-8?B?MVdSM3E4R3lNTy9IT1h3TGdwRlBTSEZtcmFma2FiRUJQOEYyUmtUdnpnVlg4?=
 =?utf-8?B?aWpmWXNBbURqSWlJd1JJUUFTbHZrMGMzZG54K0taZVdVU1pqdE9lcE8zUmhL?=
 =?utf-8?B?OXVsU3VaSWZEcVdiWWc2Tzh4WUZ5MXIwSUd3TXM2SzZ3YnAzWVFkcnlQbmFu?=
 =?utf-8?B?SFNqRFB3eHlVUWQ4SGFLejF5QnBrS2RxUE1IR1hoMUE1akpiREF4WDR2S3Bn?=
 =?utf-8?B?bUVBaVFQRWZWU3V2VjBBeU9mRk12eVU3YVZEMGppRzVNVTRnblRNZThoVDJQ?=
 =?utf-8?B?UUh1VkJUYWxadXBTK3lsVnpCZmtYREdiVU9QV2NEYWtGbWFxNDBDdjhETUhU?=
 =?utf-8?B?ejdmQis0cWh6aUE5Uy9FdStUQW9nZG1ONmFrK0JEZGYraVNKWUd6ZzRETXZz?=
 =?utf-8?B?ZlVLZllmVFozVVExb2ljTzk2T3RMUk1JOEtnaS9NVjNtZ2VQaFd2SFlQV25w?=
 =?utf-8?B?WWVyK1U1NmZBUTNvcUZ4STRkOFZaS2h2blBLYU9HS2lRczdNYUY2V1UwcllP?=
 =?utf-8?B?K1FTaDZnN0hwNjQ3K0RCUmtvb3o1cEFFNTZoWXE3aXFTVmYzUWMreVZLK2Fk?=
 =?utf-8?B?VFJnd3drVlFLL2tJSnQwVUdicEhpSEhZUHVIOXpON1lyNjUvY3JrdXZmZUdY?=
 =?utf-8?B?c08ySWhzUVBoVUtXWVJzUWg1SkgwTktaWnhMcmNReHFBc0g5dmJhTGNWSnBN?=
 =?utf-8?B?dDNWbEtnU3o2S3IzbXZZUDBZWUJ4UUZPcTJWbHIvYW9GWWFOcGtvVm9NK1pQ?=
 =?utf-8?B?d0YzSjcyUFV0c2VmVVo1TGsrcmpPcUM1eVJuZnM3Z1YyUVB3TGFmRkFuMk5z?=
 =?utf-8?B?K01jWS9WcXJWZ0lxM3BjTHYrTThCeU8zbVRyLzlTelFmeFlvKzA2NTVmTnk2?=
 =?utf-8?B?b2xVdUNOUTlpamJhMWFXWlNkTWg3ejI3d0N3QW9udTdOYUVwSS9uc0tGQzY3?=
 =?utf-8?B?cHlBdGNFbUVMZUlMZTV3SFBKMWtmbFdqVDczbGQ5TEx3UFZWNUdhVzRBT2ps?=
 =?utf-8?B?akNwS3pXd2VyamNHZ2hVQkE5bjA5dzE4K3V2QXRUTk8zZTE3dmdwd3psamlt?=
 =?utf-8?B?ZGErYmlOdWhSMTdWUE5oa2ZBL0VlZTk0cFc3OGRMUEwxMG9aL2dhZFdRNG8y?=
 =?utf-8?B?aGtTbHZ2WG4wMHR0aTVPajJ4VTdrSHMyekVtamRpOWZaYXY5eHZ4a25GbUpY?=
 =?utf-8?Q?ADaM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THp2T1FFR3dyU1dPQUQwdGYzeVVUa25tR0tPNzNnckttWHJ6OGZaTkVFQmVt?=
 =?utf-8?B?bERvMUhUei83THFUVFpGMElXdGtnYnBwZjBkZzQxK1c5WXVPSXlCZTFMclNE?=
 =?utf-8?B?NHZuekRBbFNsVkFuejhZU29BZGwxdHBOQm9ldGM0M0VEWkIweXFIOHl4ekVo?=
 =?utf-8?B?cG9GL2JhSFUzTUtyMUYvNWF2ckh4RkxOVnIxczlxNnN1MCsxTEtlRXlqVVhj?=
 =?utf-8?B?em5LVWZ3TEZDOWJvNEhEMUgzemNjTWdNak1ET083YjFwM3djM2x6ZEg2Ulhw?=
 =?utf-8?B?dHl2YTVQeVVyTnBNWmJZOE9BZVlsVjlBZHpBTnBTMEllem9JbkgycGdMZUZj?=
 =?utf-8?B?MzUwelJSMVRsK2Z1RmpxbmlxaGtQdmdteHdyNmRjUmZpaFdHZlkydzlMOFVQ?=
 =?utf-8?B?a2VZYkRxc2JmQmxncGh4MGVLcWE2Q1J5QkZzM1JXU2gwNDIyNTB1SGR3N2Vj?=
 =?utf-8?B?bzZMUkt0My96UnNCVXUrYjB2MDlka09XOW1oNHo0ZXdGV29mZHFCajV0VFZP?=
 =?utf-8?B?VUlwRGFTaEdkK3R2LzJwNmhXZ3lCdzJvekk3TzFZMm9WUldyWjMyWXlBYUlZ?=
 =?utf-8?B?bGMxNzBWZjJVYms0S29XcDVuQ2FmWU5TT3VibVl5M2g4OXJGd0xYbUMyb25y?=
 =?utf-8?B?c285Njl0OThHYjlTM3NLY2daMjE3eS8zd0hPc3RhWXJmbW85MjFFTnJBNzdy?=
 =?utf-8?B?NXBvblJ2SHFQT1JzZ1c2eXhOaTM1VjFXVGdlRGpCak91V0ZLZHlocXhzcGs1?=
 =?utf-8?B?cFIyOTVXY2laQmNNU1cvQVBiZUJldnJmcnFRVGFMaUk1Ynp4dy9rQnZRSkFY?=
 =?utf-8?B?M1dhbndMaGI2MkRJSVJMRTdrUThJam1RMkIweWFxT2VvK3JXSnByZnkwU3Y2?=
 =?utf-8?B?VXZqVmRUbEdtZkN6YW50LytIcTJSK1lielYyRVZWMEIrbDR4TXpDRnArS2lo?=
 =?utf-8?B?dXpQb1hpYkhEdlMyTXZNdzBBNXhMTWxiSmN3MVlqR1VqY0YzNHpvQkRXT0JH?=
 =?utf-8?B?Y0NoeVdXcTIzVHp1UGgyYStBSmM4ZGQxTElTdFppMUl0d2VTV1FSbmU3Wi9R?=
 =?utf-8?B?WTJ0bk5QbVVpUmVEWVh0L3E5Y2FidU1mSFJDa0lDVURucmRGRXE3OGZNeVBQ?=
 =?utf-8?B?ekVQclBuMzNobWR6bWpQUGVyUFV4dlN0dTAya25YQUFmMzAzczFJSHVTbGFD?=
 =?utf-8?B?OTczN1NDMi9pY2p5YjRWUUtSVldhcE1rSTJmOVpXK1hKTUpjUG1YZkthZCtC?=
 =?utf-8?B?UWVHSzAyaXVtbklPa2V0MnFobHJtWHJ4UUFDN0w1QktKd1pMYzhiek44d0Na?=
 =?utf-8?B?c0plZWM5WWNPTGZGdXBIVmRlZ3JGSGVjNDRuRVFhRFJpSzdWc1FoUDFOR1B0?=
 =?utf-8?B?UVJmSjNaTVFCZGJ4UFF4T1BJYmJXY1Ywd0t0M0JkRTNvUkQ2cVVlWkNLTjhr?=
 =?utf-8?B?b1BNMytuOC8yVVhwWk1jdHJYa2JZai9qZWZ5akthWUphdmMrcWxoMFIzOXl5?=
 =?utf-8?B?TVlLZUgwcFQvQzA1TVdkZDZ6V3VWbjdxMU94TFAwU0FsVHNjYmUrUGR3eU92?=
 =?utf-8?B?SFlnSG11WmU0TzM5VnkzQlZ4N3RycE16VkVmaUUwRytUT0lWM1lSOFE0R3Nt?=
 =?utf-8?B?KzZ1Y2ZCYXNDbmx4aEVWbFV5Tzd4c0NOSFZmOUE0TGQ2T1g2V09DTE9WaWpG?=
 =?utf-8?B?WDRUaGR6WUF1TTRYM0pCWFVDaGRKNkplQ1RkSzVDczl6R3p3bHNyck9DbC9Y?=
 =?utf-8?B?YWN0NEgwd2VIS1o1UkU3a2V2Tm1TQkN3RW42OFp6S0Erb05rZG5KL0hPRUI1?=
 =?utf-8?B?aUhpRktVYzlCUEJEQ1RteFlJMllvZ1hSK0o2MmVjUXR5S1J5Qm9GL1JHUWdE?=
 =?utf-8?B?MGNCK1N5NUw1OW0vK2xHRU9qTVp5d09mR2F6ZWsvM2dnOGEydndZaFQvc0Vo?=
 =?utf-8?B?UDZ6dkRNU3R3UXVtTTB5ZjhHS0NYaDRpbXVweFh0Y0FyUzVuTE1uVlVRRGp5?=
 =?utf-8?B?bXhFeW5tbnFyYW1ka1N0djB4RGxuaXBOOXJDWTV2OFFSdk1mdnJDU0RIN295?=
 =?utf-8?B?eTRiL1U3NHM2dWpub3VPeDVMd0dTZ1NiL1NEZURsbmFBWkFpR3lMejlic1k3?=
 =?utf-8?B?RDljV012cU14QmJaa2cxby8zTERpQ3hSZlNrNWcvN3p2Y21vUXpFZ1I2MUY3?=
 =?utf-8?B?YUs1Z3lyaFdiUUlqZDlIaXZZaVVMZ0J1RmxiRGdQODByMXpTc01wTTdFSExH?=
 =?utf-8?B?K3ErS3ZLN1oydWVuK09wSC8rWHFxZTlaZG80RUdmdVgybm5KR2FaZGp3eDk3?=
 =?utf-8?B?OHVnSzBwazZ2Wmg4akxLUkhiOEZOMEZJVXI5SkxrWFRVQm96Ujc1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051bd260-8a5f-4908-26f9-08de58b36bdf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:07:57.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ3Z+Szr44bu9V07dh/fXE0pp0T7OUpYf1Yl3DVRZxOCRgCw3kafNqS96GwJK6P4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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



On 21-Jan-26 8:44 AM, Yang Wang wrote:
> resolve the issue where some freq frequencies cannot be set correctly
> due to insufficient floating-point precision.
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index efeaa3d57712..b0d6b7b0946d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -55,6 +55,7 @@
>   #define SMUQ10_TO_UINT(x) ((x) >> 10)
>   #define SMUQ10_FRAC(x) ((x) & 0x3ff)
>   #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
> +#define SMU_V13_SOFT_FREQ_ROUND(x)	((x) + 1)
>   
>   extern const int pmfw_decoded_link_speed[5];
>   extern const int pmfw_decoded_link_width[7];
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 51f96fdcec24..e27ea0879429 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1554,6 +1554,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
>   		return clk_id;
>   
>   	if (max > 0) {
> +		max = SMU_V13_SOFT_FREQ_ROUND(max);

Looks more like a firmware issue. Isn't firmware supposed to round it to 
the closest DPM level frequency?

Thanks,
Lijo

>   		if (automatic)
>   			param = (uint32_t)((clk_id << 16) | 0xffff);
>   		else
> @@ -1565,6 +1566,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct smu_context *smu,
>   	}
>   
>   	if (min > 0) {
> +		min = SMU_V13_SOFT_FREQ_ROUND(min);
>   		if (automatic)
>   			param = (uint32_t)((clk_id << 16) | 0);
>   		else

