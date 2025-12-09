Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19917D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 10:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84ADF10E068;
	Tue,  9 Dec 2025 10:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IU1OpQ74";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D5910E068
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 10:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aX/QMuMznIzNQ1j2iyhOV1kbh/N88C2L6HUt3qx98iD8qbwc9N5ZZp/7ELfBHw5RZRUf6LbO8bDvSrPLxDaiSuGl5NRuopOqHgDb8ZYjvfLEgtCwwOHfCZUY8LlqZGxShYEONvEQxv0KO0709OjxoKuKTbjOqhCzmUEJFz/Obsd27pHL69wkhVkpW+j1637WSWdtuOkKybRopE8rCK058Vjsqw0zh2EpJVXMf6Mnw5Nbm5TYoCgWEBWZrQ0eF0bWi9+0+XHcCd9g0rMQ47+yCT19SBCBMQW1wYIEsdd4mdDLqjm5znQBc5iet42vmDAsUyEsxcWNH+lWrkbIE2QuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eQfRnJNh9RdCerFhFWU5w+boExulp5J58dy77sBUs8=;
 b=ira1u91iYDgLHg9tRCh1wy5Iq4BPlThEKRO2j0QH+sxw+95i/gSIaUyEsFx9gDoAGrTpYTZa//GyvYLtqxfri5CaEmdmBIPi5fS4suCBH5nXOT5Ko6OQcrsl1AyJD8OOVo2Z3WYg8LSbHdUGZgmRsd2/SS5ZGPXMos+D8tmaFo8wJfY3Ev8Nf/rE3z3baSxe3fxSqdV8rJubkkgsugm6ZGCCMQkRs7e6eG3myla1wY9bODWzdCabBZ7mNatGMOwQO+ZcEjQrAZ3yZMwpsI3A9sKPxay6wV9XeH8U11xMeE/8bYowgRjRPm1SJ0Xhj1gKPiFKp3eUp8NSRHewBIXIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eQfRnJNh9RdCerFhFWU5w+boExulp5J58dy77sBUs8=;
 b=IU1OpQ741HNH5bwOlK4tnu+gxMZU7ZgyG4CGg8x5wb5yP7KS+GRMUa49ylbqcA9olXX9e/g5naQtCfDgywuG0IoxqADoiG6++RBVaabS2ffx8g8cbvPfCcsVQtrLiGqAjuZgbzG/VRaVJv5hnrkpFop/Og3gBylUUdEpLDqky8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Tue, 9 Dec 2025 10:02:49 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 10:02:49 +0000
Message-ID: <4e4a99a9-5fff-42c1-ae5a-b2f925df2633@amd.com>
Date: Tue, 9 Dec 2025 15:32:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: emily.deng@amd.com
References: <20251209073831.1426657-1-chongli2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251209073831.1426657-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f6ce66-6f62-4f7d-675a-08de370a1ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUxzQmR0dmlPZEJvSXBHaVpTY1J4K1BON2lpRStma2hwdWNqN0w0ZCtHTURl?=
 =?utf-8?B?UmYyRStDQjk2ZWFNLzcydGtTYlpIdTk3aHNDNmFSRUxrQVlYVG9tWlc5cTBL?=
 =?utf-8?B?M2V3MmR5T0ozWklmcERoRFlIQzBGWVM2eDl5WnY0czFEck9lWWhMNkY4WCtr?=
 =?utf-8?B?Qk1kWWxidlliTGtLUHpiN3hsL1I1NklVSTVzVDFMd0hnUlZ3ekNpa1B0SjBW?=
 =?utf-8?B?ZHZxVXNLd3Q4THh0Y1V5cnplQ2w1WXlycE5BK3JXYzNKeUpmU1pQYkFVUjNp?=
 =?utf-8?B?eXVURXFMOTFDL2x2MVpoZ0JKOTV6d3ZtZnBHM0lJL25hekM5eWdKaENtdVp3?=
 =?utf-8?B?SVVPMlBpOWIyWXZJNGllTVkrWmtDTmtZV0pDTE1YTEo1bmtLemlGekpYbVhR?=
 =?utf-8?B?WFJaVE9uaENJRnkydTFxamwxeFVpRmxNa0hvREJhR1Z0TkZDN2lUQ2h1SDlR?=
 =?utf-8?B?eGpBakdhM2huNzF2dVl5VlRHanpTZW9Jd3c1RzA1UXBNdGJ5VDFYeEhsa2Mz?=
 =?utf-8?B?YWROdlB1M3FNcElpRHZ1U2JsaGIvb1grTFVCcWNCeHJEQXgzVVlMOEZNQXQ1?=
 =?utf-8?B?TjM1QmkyQXF4V3ViNnBNNXJkdkk3RDkyTUpPMlJCUDhGMXRmM0FwazJ1b0ZQ?=
 =?utf-8?B?ZE95MG9QRFdVMlBYRTFkZDZnakxUMmMvL1BiSlpuZWNhMEl0UTVjVFdCK2N5?=
 =?utf-8?B?V3Znek9pQThTS004cE11Y1Y1VHl1V3JWRlhFbU1QdkVYWWpMYWpRN1pSUWdX?=
 =?utf-8?B?K2h3YkMySEVmQVoyUXdZSkF4blp2aHcwZGlxekpLc1kwUXpLWnBKMGYwWWVy?=
 =?utf-8?B?MlJ5SStzWVd6M1cvREROcHlNcFY4THZrMERLZXRqVUxCZUdnaDhpak1QcGk3?=
 =?utf-8?B?TzcvemxwdWoydDlZbFFmYTAreUFmVjhSb0c5MDgxQTRVcWtpMHl0Z3M1U2xu?=
 =?utf-8?B?b043VGNXeUZEK01pa0xNMEdLWnZrdzVFTWxjMThpZjREMGFSMGpJL2gwaXVp?=
 =?utf-8?B?KzhxR1ZacjNadUUxMGcraURBWmdVcWlFdjFzK0pQcG5TV0djM3ZtUHU3akxL?=
 =?utf-8?B?VlRwMG0zb2RQaWdDdnMrOGZZTkZkb1BhcVF6N2JCQkJwbk16VXcveDcrSFlq?=
 =?utf-8?B?ZVBtSFRtT2pkYkh4eXR3RlFZREQ1ZDNtYjh3REFqV1l3cXhHQkFNeXlvQ0l1?=
 =?utf-8?B?WGpmMGh2M0FTcURrNG1wSVh0M2NKTk1YV013UTZNS0ZiRng2TElJV1MwMTBF?=
 =?utf-8?B?dDFhR1lPMUU1Qm4zUEg5MzJhb1ZUUUVKMWYrVG9NZEFxRUVTalZtb3VRUlRm?=
 =?utf-8?B?SnVCOGRmcnAySHY4SDNYN1pQWmg3cEQ3enJzNDFZM01VNzVDVmZNNG1nTk1y?=
 =?utf-8?B?dkNxV3VsNGVrU1MweUtkZHRuVUNjVjBPVXFSOUg4bEp4WmZjOHFydU9vZzEz?=
 =?utf-8?B?b2FzcHpXWXRMOXRHcHdyaGE0TStyVkUzaHNkWFUvWk5mcHJGZUZTSWxoZjhp?=
 =?utf-8?B?WkJuYVd1WTIyeG1FVkowZnE3WHZjOTladVVuSTFtWnZ1bW8rald4RDN4VG5W?=
 =?utf-8?B?VnNremlBZmMxN0N2a21PZDB3ZkZ1UjJiYkxxaHFtTlB1c09qZ25OWWVIZkFM?=
 =?utf-8?B?NGdQRlNIejUrVXlzQ2VjREVGbS9OT1ZvWmcrU1F6WEw2enRPZkZ6TlRjQ1pj?=
 =?utf-8?B?NlRTQUh2bGlRTW0xR1hMZjJSUFFkWTc4bjdCbWdMU3puZzF2M2xac2JUOVQ0?=
 =?utf-8?B?cWtOcVJkRkVHWDBjN1Mxbm5BZ3JubEFid25pWHlvVElQamdjZDFsNEhNZ1ds?=
 =?utf-8?B?ZzFpcllhMHhsRlJLcXIrdnVEUHBlemdaeEtGcEkwNkFkSVYwa1g2TkNiUE9r?=
 =?utf-8?B?OFNlbythVlBuRTVtODdSNUIwV2dlNVFtMlRjbS9MMlFTS3d0Zi9aT1NVQThs?=
 =?utf-8?Q?Apyh8Hmx7FuvsJVj6Amt5wevypycLX7x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZEQUdOaDU5ZE9jTExNOUVnbG9jZ0FtREV1UkZ3cmh6NnBsZ0Y4M21ieHJy?=
 =?utf-8?B?Zk1tZVFyLzhYanFMeTh0cVNpQmtmVDU5NXBqblVlVVNtNGg2M09xY1VoL1ZZ?=
 =?utf-8?B?S050ZGwrNi9WTFcvVDViYmZlN2Y1ZXVYaFZjcEc0bjhDVmU5T09tN0FzWVpY?=
 =?utf-8?B?QnVRNU1keDNRVVNLbDgyZ1dLOVVvVVBaOG5veXZlemIwbWw5VjVyM1l3R3BT?=
 =?utf-8?B?WDhaV2E4cy92ZVIyZk03NmJRRG0yZ2Z4MzVVMlNmK1pSdlVMV3lXaWVBaG9B?=
 =?utf-8?B?U2J4S1dLVmIvaWlVWlg2b0lBbkNPajBJek41KzRaWWpvQitqT3pELzZVdDcx?=
 =?utf-8?B?bXZlNjMxVXRBWi9sc1hPbjk4TWVuVGxLVmJwSlQwWXFtSzFYS200NXZwWVhP?=
 =?utf-8?B?TkhFTkNENytBckJGZ09vOG5saG4xN0pWRlVUc2V3czZGUWhwYys2SUJKWHE0?=
 =?utf-8?B?eWc1bmtKdU85Qk9qWkowM003OWdxdEdZYVQ1RGhhY3FRR3VZazVOVFRXcG9Z?=
 =?utf-8?B?bDlCRFkyTkgyNjhPMnRQWXpCTStGT0FEYkRIVTUvRlBuN24wdXk5akF0dVBw?=
 =?utf-8?B?YWh5MnhaMkhabXNjUHgxM1NNeEE3QkU5dmo2aWJwVVhuRklrOFN2VWw1eHA1?=
 =?utf-8?B?S2xqbDltMDN1WDlNK3ZOVGRTMTAxbnFWMHY3SVhvdno4ODBOL0dBTlJiVndX?=
 =?utf-8?B?bjdHVVJrNjFPRGRjNHduZzR0ZDZnelhVYWxENjFsaGpIM0FWZ2xkV0F4ZUd6?=
 =?utf-8?B?MHF2aUxUTVhqRkRkemg1enVUb3Nab1UzNUNsS3E0ZEVmSFRVOElIWmJaTWc0?=
 =?utf-8?B?WnVEbTdoRzN0Y29mQXRQMm83Nmw4MVlJRk5kM0Y1dUREK2lrNThXMEovQVg4?=
 =?utf-8?B?T3NscGhEd3h5eVdCZ1VBMGpVTk0vUHlRWmNmOHl0eC9STUxJWEd6L3oxM2E1?=
 =?utf-8?B?ckl1Zy9PQUlOT1FkLzFMcFFVTG1lc3AvVjFQc0s3Q3FrQ1BQbmk5dEo3bDYx?=
 =?utf-8?B?QTljakxDK3dOSU5xRU55T1lUTE5seUt2RVpiV2R2dnk5ZEY2RjhuaXk0Yndx?=
 =?utf-8?B?ZXVqNE5mYUlaK0VSRlZEVjJLc2hqbVdpbkNXWm1YOEVVU2VSdDRwc1c3dzQ5?=
 =?utf-8?B?TE9tOGI2UGU0MEhKaHh4TG9lWFBWVDJsMFdvbW1qWFk0RWsxMlpuWFZBVjB0?=
 =?utf-8?B?bk56MHZFc0xoRzhhODN6SHljZFZrZ21IemtNclRZWHVHSTFxa1BsUVlIVkE3?=
 =?utf-8?B?ZDhKR2syVkRTK3NRZWszY2xXU1FHRHZoT2VLUGtqVUNhZUU5L2tLWUFrMk81?=
 =?utf-8?B?RC9LWlU1NmpDVVJuT0ZVZ3IvaEN6RDRFWEthR0xpMjJmdWFrN3o2NWRMMHp3?=
 =?utf-8?B?TFRsY2Z4WldFODZTaitXK095WEZud2hsdUgxNkNwbGs4T25rTjVTU2l4UXlh?=
 =?utf-8?B?eVE2aU85Q1BvRGRvOU9hQUxpdEdBM1JVZE5Hbit4QXB6MGExYVlQL28vTnBU?=
 =?utf-8?B?UndpYVR1VjhZY1dNa2lzSlllYVo5TEFwWXVzYUIrdmk2TjFJTWk4SGZLTkxD?=
 =?utf-8?B?N0JmdFduZTlSblEyQ3Ywd2paU01TT0hXcmNTTHVFYU9FVTBoWWdoQ3J3TFlI?=
 =?utf-8?B?TnhIMWx6SnZ6aDkvdVA4bUhrZHQ5N2tXektkMjJ0R0h3dGlGc1MzSUxlRXZp?=
 =?utf-8?B?aDNhZ0hqYk9GTVJkSlAyMlBkSk5KeHl3NU9MTVhtei80Mnlocm1WTG0wd3k3?=
 =?utf-8?B?UzZwQnVDTG0yQXN3cDBOaWFIQlFpTElrQ0VqMW9oTzAzVHRydlBmWC8zOEo0?=
 =?utf-8?B?V1NmTGZTSE4xRm1WTERXb05Eb3NVSEx5ZGVhd2hoREJCNUp2dzBrOGNjOVEy?=
 =?utf-8?B?Y1dBRmRWazdpbzlnb3lZNW53c1JRVFJyb1kyK2RmOWdaSk9HNDZKbEVXdk0w?=
 =?utf-8?B?M2JFMm1qUWFrdzdHcWd5SndOVWNRV1JTYWJvSm1rRlpjL0J6WHNOTkdLbXhW?=
 =?utf-8?B?c2JHbXBsbE9CZHFhQUcySVZvZ0hLcXVvTGQwVy9tdG5saXVJU1JGN29tbER0?=
 =?utf-8?B?RytyTm1vcjNSZGF2QTJ0UVJ2V1B2RjM1U2hDV1NoNm9YaWVQRi9STlJXRnpy?=
 =?utf-8?Q?AdYvwQU9Bgrga0BGDS41POY5s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f6ce66-6f62-4f7d-675a-08de370a1ba4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 10:02:49.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXe9yHITlMgn15lmdBwcXp4uVedS5oeDREfoZggdZNjmfHruT8iG/JtMOwBMU+NE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862
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



On 12/9/2025 1:08 PM, chong li wrote:
> v3:
> Unify the get_ref_and_mask function in amdgpu_gfx_funcs,
> to support both GFX11 and earlier generations
> 
> v2:
> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
> since this function only assigns the cp entry.
> 
> v1:
> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
> 
> use function get_ref_and_mask to assign the cp entry.
> reassign mes to use cp8 instead.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 54 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 55 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 55 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 54 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 54 +++++++++++++++--------
>   9 files changed, 275 insertions(+), 128 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index efd61a1ccc66..090714127cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>   				     int num_xccs_per_xcp);
>   	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
>   	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
> +	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
> +				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>   };
>   
>   struct sq_work {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 895b841b9626..5c7724f203d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>   
>   int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>   {
> -	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
> +	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
> +	struct amdgpu_ring *mes_ring;
> +	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>   
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
> +		return -EINVAL;
> +	}
> +
> +	mes_ring = &adev->mes.ring[0];
>   	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>   	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
> -	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
> +
> +	adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
>   
>   	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>   					     ref_and_mask, ref_and_mask, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index aaed24f7e716..ed79ceafc57b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4566,6 +4566,40 @@ static void gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
>   		WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
>   }
>   
> +/**
> + * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +

Need to do NULL check of params (this and others).

> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v10_0_select_se_sh,
> @@ -4575,6 +4609,7 @@ static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
>   	.init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
>   	.update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
> +	.get_ref_and_mask = &gfx_v10_0_get_ref_and_mask,
>   };
>   
>   static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -8614,25 +8649,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f4d4dd5dd07b..c3d8e7588740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1072,6 +1072,44 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		case 3:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v11_0_select_se_sh,
> @@ -1081,6 +1119,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
>   	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
> +	.get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
>   };
>   
>   static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index f9cae6666697..b805ed4f88aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>   	return -EINVAL;
>   }
>   
> +/**
> + * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		case 3:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v12_0_select_se_sh,
> @@ -938,6 +976,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
>   	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
> +	.get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
>   };
>   
>   static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 66a4e4998106..b3ea45e3c60f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2068,23 +2068,10 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>   static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	u32 ref_and_mask;
> -	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -	} else {
> -		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> -	}
> +	int usepfp;
> +	struct amdgpu_device *adev = ring->adev;
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>   	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
>   				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
> @@ -4075,12 +4062,46 @@ static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
>   	cik_srbm_select(adev, me, pipe, q, vm);
>   }
>   
> +/**
> + * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;

This doesn't look used inside this function.

> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> +		*reg_mem_engine = 1;
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v7_0_select_se_sh,
>   	.read_wave_data = &gfx_v7_0_read_wave_data,
>   	.read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
> -	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
> +	.select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
> +	.get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
>   };
>   
>   static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 5d6e8e0601cb..cc5acfcdf360 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5211,13 +5211,46 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
>   		start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
>   }
>   
> +/**
> + * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> +		*reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
> +	}
> +}
>   
>   static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v8_0_select_se_sh,
>   	.read_wave_data = &gfx_v8_0_read_wave_data,
>   	.read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
> -	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
> +	.select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
> +	.get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
>   };
>   
>   static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block)
> @@ -6000,25 +6033,9 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>   static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	u32 ref_and_mask, reg_mem_engine;
> +	struct amdgpu_device *adev = ring->adev;
>   
> -	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> -	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
> -		reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
> -	}
> -
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>   	amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
>   				 WAIT_REG_MEM_FUNCTION(3) |  /* == */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e6187be27385..f2ebacc73eb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1997,6 +1997,40 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
>   	soc15_grbm_select(adev, me, pipe, q, vm, 0);
>   }
>   
> +/**
> + * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>           .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
>           .select_se_sh = &gfx_v9_0_select_se_sh,
> @@ -2004,6 +2038,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>           .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
>           .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
>           .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
> +		.get_ref_and_mask = &gfx_v9_0_get_ref_and_mask,

Alignment mismatch?

>   };
>   
>   const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = {
> @@ -5380,25 +5415,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 89253df5ffc8..b4ba76110c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -838,6 +838,40 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
>   	return xcc - 1;
>   }
>   
> +/**
> + * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v9_4_3_xcc_select_se_sh,
> @@ -848,6 +882,7 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>   	.switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
>   	.ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
>   	.get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
> +	.get_ref_and_mask = &gfx_v9_4_3_get_ref_and_mask,
>   };
>   
>   static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
> @@ -2818,25 +2853,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   

It appears like gfx v9/9.4.3/10/11/12 all can be kept in some 
amdgpu_gfx_get_ref_mask generic helper, then it's not required to repeat 
the logic.

if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
	ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
	switch (ring->me) {
	case 1:
		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
		break;
	case 2:
		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
		break;
	default:
		return;
	}
	*reg_mem_engine = 0;
	return;
}

if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
	*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
	*reg_mem_engine = 0;
} else {
	*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
	*reg_mem_engine = 1; /* pfp */
}


Thanks,
Lijo

> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			      adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			      adev->nbio.funcs->get_hdp_flush_done_offset(adev),

