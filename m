Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB75C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 10:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8606010E801;
	Thu,  6 Feb 2025 10:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7ChIzKo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386A010E80F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 10:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEBZ3AAk4eVM4LfSSx9+BnnDK5y1X6H9cpb130ZIZ3vcBiBrldPLNijoy5vSBLdXHW7Vpdtv7vCKatjkr4KSxJqvSm0zu9wpep0dair1EnP9ml+fHgSXgHohTwu3oIXmkexQiLcWXcHKzflr1eYWUna35U8Ril+HICSP4gMIcKGszWHzvcmU38147KjQoRzxlBmSfLaeIqDRPcUncjqDiCFcztMUFuRQ0pDDOvMWL9Ok5efn8EkT4Ugnsvt3+XstBNXPmnfLGBzlZzLKJgI2Hl74XFCHSdtr8yBX6Rjy3kd6/POpOCsayWPFOgUwJIfFEkgjWXMBacy1pW4ylHMcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5TihDZvtEJtJgELkr87GBpzbmtGypZXIcECyy3Pyzw=;
 b=fSk0iQev+4T7YZCnxhneNJqyCDws5notULa5k0/K0VOvbEuVJ1Fe0mH3Wl07f2wrho7zC+LjWB5FbNWOzeVReETG+NP19er9/eVMRgAXBuwARZL2+rLMlJwuz82UHRBw5ZlQZ1XrgtIGb/035ePSysnp2yUsLov50wMDsWQe5X1DR02rGcFZAA4xpco/f7AMY4qzSsIjfXbQwW70rr957R8ZRiW3PHGNlZqAjGS0reQ/hK9Y3poErdsSYEvz0kYfPVOGEdXxpfHXritdmNiteIcgV4ROgLAeklUE+Ue5Yqy/3Ditu51poSuHTT+Twjt7t9nL02hFc+EjNnveWWKtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5TihDZvtEJtJgELkr87GBpzbmtGypZXIcECyy3Pyzw=;
 b=K7ChIzKoBKFmcuFji+Ie2XPDrMK3KfNGFwwnNcGh6W/qn6K0uMNLPbWS8et/2rWG/mOcAFPN2+F0/tLDjFhDy3upKClY5oX5uCFfEPos9i9iousDxKDBFywNLg/P5v3GXrGeshR56kT9gmXWXJ4mXBNKeDwEiNDN5EH1om3kxpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 10:25:47 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 10:25:47 +0000
Message-ID: <778bf7e6-cb17-49e8-a5e5-a3c06d617066@amd.com>
Date: Thu, 6 Feb 2025 15:55:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: set
 CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 for sriov multiple vf.
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250206094106.1562194-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250206094106.1562194-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 3314e0bd-6bed-49e6-148e-08dd46989ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFE3WEh0Z3JsT1Y5SnFZL2tLblU5S21Zb3hxZTZnMjZGQis2TklEb0ZZTEpU?=
 =?utf-8?B?OUpTR3F3Wjk2cy9oZk9OOUY0QTJmTWp2RDNzYWE0M0VmY2VzdE1Zbk1xL2Jo?=
 =?utf-8?B?RXZWcHFjOWtTZmNyM1ZpUE9ubU1vR0pjTzlGTkV0RUp3dzltTWRqYzdZUVBr?=
 =?utf-8?B?NERFWmtKaTloRnJvcTI5Y09ocDdkUUpObTJiYWw0bVZEcE9PK1dWTnpYVG8x?=
 =?utf-8?B?NEh1TmowVXhsclRqME5kNHhmb25QRWlsVW5sRmRYaVFmN1R2WHFDYmFDU002?=
 =?utf-8?B?THZzYkFPZkoxUkgvWDludGMyRlR5K01LRlFoeTJGQmRiYlJ2bkRCTnc1UndQ?=
 =?utf-8?B?bnB1SFZYamhVdjBISTdNY2VJdWc0dFJxNy9xdDh0RGZKK0Y1SnRqWjkxUk9q?=
 =?utf-8?B?aDFPQlFMdWgzRC9la21iU1p1enRyRTYvcFJRT1VDWUtSQnJTMllXTktEeXNY?=
 =?utf-8?B?UVd6WFZlanZnMXRtbWtXcjIwUlYycUpmWmRxVnhiVzJhY1pzQmlZN2dqT3Q0?=
 =?utf-8?B?cnh3WlNMU1FGRjBYT2RDYjlvT0FEdkxrSVVNa3ovMVFaSHlTYUFNbmtHT3BS?=
 =?utf-8?B?K0JzVkYzTkRjdFFMZGFKd2dMeFJNTFRlS0sxV2ZibExUeVExaWhKSVpFOWZq?=
 =?utf-8?B?Nnkzblo4QUFCSVFVWjFZVFZtNXhBTnhpenZwVm9zdEJtR0lGdHZFTXhKRmRF?=
 =?utf-8?B?TzM2eWc0MDgrd2dOaUltOVJWdEZmMFl4Mk0yNFVrU25JOUkzWlkvR2lPYnRO?=
 =?utf-8?B?SVpwdXJlWTgwTVJIQ29FYlBwVDR0endkNTg5WFgxcTVmMTYrR29GY01NNTE0?=
 =?utf-8?B?VDRScDNkckJhTEJKdVZ2Mmt5WXNFa3VHLzhCVmFybjNNcVR3L0ZEdzl2eFkz?=
 =?utf-8?B?aTN4OEoxREU5K2ErVWhFdTkxUFV1cHR1eFNVdjc1eUZzYVhFTkxOeVpIaDhr?=
 =?utf-8?B?ay82bU9UM1NZMklNS0p1LzczM1luVFRrcWRoZm5Od0pLdi9pRThPalRyaTVQ?=
 =?utf-8?B?TWdFVVZWSFpCeFJhMGZ1aE91RmI1ZmN6VmIrV0tzakE0dktTTnMrQnRCa2Na?=
 =?utf-8?B?VlJCQmF0WlViSFFVOHg2bTBaUlNNWWZOcnpNeDlncm0zMFZOSGVSditRYTln?=
 =?utf-8?B?QThLdXVKcERaL2FDcGxIc0NLOG5PRHErd2Q2RkdjL0lhYnRVM1pQVmgyRzlv?=
 =?utf-8?B?S0g3UHd2a25Jb2FEcTFENzY5aXU4YjFZZlNoSXF0dUQ3OUgvZVo1VlpXeWQ0?=
 =?utf-8?B?RnNyTmtUcXZDOEpVWERJbk9oU2dCVVNaditMZmtqZ3l0YUdsc2pGUWY0ZEhn?=
 =?utf-8?B?TkdETGJYZ2paNWlzQ0gxcjVKeXNpSnNRaDhsd0cvUjdtb1VnbFFKdHZvSEIv?=
 =?utf-8?B?YnpYSU1VcWdOUk1YVkQ4clhTSmZOVXZLY2J3NGxFdlkzOXExc1Q2dlRCU0Yw?=
 =?utf-8?B?RVNwbHI5K2FsOFZaa0M3ZWFnY21udzRuVWVFckRIUGtmTFhJWU5rd1ZWNnd5?=
 =?utf-8?B?YzRWTnByN05seFlNbG14UXQ5RDYvbVljTkZKYmNhTnlrRktGdVZRZjVGUys5?=
 =?utf-8?B?NDRjN2FtTnpXbUFHTUxMWnAydTducWo2T2RuV2VxRVZFcmdrOWN1bSs2eWNL?=
 =?utf-8?B?SzVKT3VzTFY1SHdsZ2hYN2JzVklGVEtJd0QrNTBjRzFHUVRva095NkpTa3po?=
 =?utf-8?B?ZXlrdHhpcnAraG5BWWg1RFhqS09JWUMvTU1uTE1OWjZYVi9tVStObHJuOEpz?=
 =?utf-8?B?OHVqQmgzRmJrSUxOejZUVENUeGJVN0FPbEZEaUdMcG03Tm9ySGg3MUhQb1Fx?=
 =?utf-8?B?TUNWM3dyVXdCem1Qb3JGT3BSR0JzQ2RvYVltUCtKOUhRQ05qUE12K1VZK3Vv?=
 =?utf-8?Q?Nd74ZlMD1B3K4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlA1ak41YVZXWVNWSStqSWZibkdkNGFkbjAxQWg3cFZqbjFvcHR4T0JHYWhm?=
 =?utf-8?B?N2l2dk1oOGtQaEhkbmFSS1NQbndqeEVTeWtqZHdjRVFFQzF1Zk00OGZvK0hE?=
 =?utf-8?B?djNzNDBEdGsrRXRqQlIvaWQ2WksyWmNZdi9keVVCY3VvQ1lIMmdiM2dYWlN5?=
 =?utf-8?B?RFErb043N2c4YzhnSmZMSkZxQjdaZE1vQmVjVFFXQU1CQU9BcWw2by9yRWxP?=
 =?utf-8?B?UDU1MlhqRjVjY3A2UDVzM3ljWWtSSzNROUIrWHpIWWRtcFdIdDd0NkYwYm1D?=
 =?utf-8?B?enRmMHRJVWJMdWIzZEx3OHUzcVMxaVlMZlhxWmQvaFRUd2lsOVNxTzNhK05P?=
 =?utf-8?B?SVFoQ2Y2Z29TUVF1UjNIOXRrK3M1VnBQTVoxZDd6aUZ2TEU5aTc4c2FjUGpo?=
 =?utf-8?B?WDNwUHpkRDUxc01Fa2I2ZVBlTjZQN0l0REFLSFBPQTFYejg3Q3VzNkN5NlRF?=
 =?utf-8?B?YjhRTnZFK1VUUk5qTTlmcEV6N1RXeG1TWkdGSFpsOGJRUno2Ym5ULzFPZzVZ?=
 =?utf-8?B?SWUyVTN3K2pwNXJjSS9CNHVJWGRJaXdtQ2k0OFoxbUxMU3dneHpna0d5Q3RP?=
 =?utf-8?B?a3RvTHU4cE9UUmFCdDV6YWZmQ1AwVEYxN2JSRmcxSUc3WXR4cy9iNDFIbjUz?=
 =?utf-8?B?a0pSbmd1NXE2bEl5b2lPU3R1NkFGZTFKM25SOTBTaDR3c2dKWHNRQ2FmZU01?=
 =?utf-8?B?dDUzWExlWkpENnVQbzI2b3VZUkNKTTN6R2toT0lHR21aN1dML2RoMEtsU0Zw?=
 =?utf-8?B?c2ljYVN4emhDQmVxek5YZjNmdkhCZEZQUWVoMFg4RWxTTUFNL25zSzdoMStn?=
 =?utf-8?B?UytMOVp3bm9Mb2lhUWY1OEZnRXVjSmdMcVBoVXJUZ2RwclRwOVF1N3NNMTBu?=
 =?utf-8?B?TU1DcmRPbmZRQzhJK29nUkVlMUw5amhKQ3FNL1owT09lVlVRSW5ER2VRVmVh?=
 =?utf-8?B?SzNHU2ZLUWFqVll6MXYxRDFEY0lrTFZaVjBuZ2NITi9NNG9JbWtDQ1IwZDV3?=
 =?utf-8?B?QU1SeURTdFcxUXUvSnFIOWU0c0dkMkNhL2lrZXh4SENJODFzMWJQbnkwcDR1?=
 =?utf-8?B?N3FwUnFvOEN1YXhmRlUvazJkMDJnZ0VFbzdDWEdHWFpPUHJiblhqbWlibkky?=
 =?utf-8?B?WWV6TGRhczRvQ0lqTGZhR0FEVW1pYTE4M3Nrd1NWU0ZuTVpRcXlTdDd6M3Aw?=
 =?utf-8?B?UFNNNEtpZklUVHlwcXNZQlI5VGJUeEdEelhFSEJVYnBQNzM3eHZZdjY1NDMx?=
 =?utf-8?B?WkxXUDhUUHZJR2NmM2twUERQSWVCcHgwT0ZFeW44cmNBdFA5UWtXWEJjSzZ2?=
 =?utf-8?B?U3l2cUlPUU5RaEdWbjZHc1JweC9zUEwyUC92Z2xacWFZM0lPV09KbXBCVDRj?=
 =?utf-8?B?aTZSbG0xcWZQNG9sZ2hBMk1pT3dqakpldkw0clNKQm5BaitWTWU4dkZ6blNX?=
 =?utf-8?B?TWJGRlorOVpaeWV0Y04wS1RpZ0JrM0JnMjBpNm8zWEtoREl6NkRoVGxBS0d2?=
 =?utf-8?B?MEFZS01ZYkRCRjFDNmtESzlpdllSUk1vNldaeGdQSEszRWdjbmZuZzkzUmUy?=
 =?utf-8?B?L1p4dXNHNXVqbXdsV25rSFZZYStncTdHQzBIRHRYczdyMnFEMVlpcnFwOGpx?=
 =?utf-8?B?NFNNcUxQWC9kOXBlaVJxWXhQTUlPYm9qUlRoSlZSa0pjTXJ6UTZpVnBIRkFP?=
 =?utf-8?B?NTFkUHplQUJnNlVpdlYvMzZ3UEdtckxJbWhFYnlCVXZpUUt5SzV1dmlJenEy?=
 =?utf-8?B?L29mNWJ0cXBOZWNJaThBOE5uOE81OWdiMHpXMlc5OU03cEhxRmM5OFVGK2lS?=
 =?utf-8?B?YjhxcU9YdERaMDk3d1JPaWR3SDN6N0lQMlhmT0FpOWRqYXdCNSszazF3aC9I?=
 =?utf-8?B?YnBpSG9tRWNjNHBFdEhxTjlCYnI1N2R4bEJwQk9BdDB3ZTBwWHRhQjI3Q3VR?=
 =?utf-8?B?RjJ5ZTJqVXFvc2hpcEoxaUdQUGo4VnA1NXVPNit6Q242MXpIV0hhQ09BQ2o4?=
 =?utf-8?B?UTRFaDh5dGpUK2t3MGZENmYyNUppN0pFR25vSEJPZjllN1ovOStvUjlidmJN?=
 =?utf-8?B?OHI4cGhoelFQZklsU0tGOXN0UjZ0bVBVRks3RUhINklaRmV4L09KSU5SYzZU?=
 =?utf-8?Q?VlF3XmepMG4sdgxlLbFYcagjD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3314e0bd-6bed-49e6-148e-08dd46989ecb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:25:47.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gewDI2iKvjmkpJ22HY+hZGFAqxU1NidL/xGZww7SvygF9ZPgUwVqS+Y8PQYsWDMd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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



On 2/6/2025 3:11 PM, Emily Deng wrote:
> In sriov multiple vf, Set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.
> 
> v2: Add amdgpu_sriov_multi_vf_mode
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 +++++++++++++++++--
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  8 +++----
>  6 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 49ca8c814455..a1450f13d963 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1990,7 +1990,7 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>  	uint32_t max_freq, min_freq;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return -EINVAL;
>  
>  	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 5381b8d596e6..b28082084b3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -352,6 +352,8 @@ static inline bool is_virtual_machine(void)
>  
>  #define amdgpu_sriov_is_pp_one_vf(adev) \
>  	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
> +#define amdgpu_sriov_multi_vf_mode(adev) \
> +	(amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>  #define amdgpu_sriov_is_debug(adev) \
>  	((!amdgpu_in_reset(adev)) && adev->virt.tdr_debug)
>  #define amdgpu_sriov_is_normal(adev) \
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2ba185875baa..42251f2b9741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1857,7 +1857,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
>  				    DOORBELL_SOURCE, 0);
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  				    DOORBELL_HIT, 0);
> -		if (amdgpu_sriov_vf(adev))
> +		if (amdgpu_sriov_multi_vf_mode(adev))
>  			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  					    DOORBELL_MODE, 1);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index ff417d5361c4..9e08bcfa37d3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
>  		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>  					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
>  					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
> -		if (amdgpu_sriov_vf(mm->dev->adev))
> +		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
>  			m->cp_hqd_pq_doorbell_control |= 1 <<
>  				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
> @@ -724,6 +724,9 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		m = get_mqd(mqd + size * xcc);
>  		update_mqd(mm, m, q, minfo);
>  
> +		if (amdgpu_sriov_multi_vf_mode(mm->dev->adev))
> +				m->cp_hqd_pq_doorbell_control |= 1 <<
> +					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		update_cu_mask(mm, m, minfo, xcc);
>  
>  		if (q->format == KFD_QUEUE_FORMAT_AQL) {
> @@ -746,6 +749,21 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  	}
>  }
>  
> +static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
> +			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
> +			struct queue_properties *qp,
> +			const void *mqd_src,
> +			const void *ctl_stack_src, u32 ctl_stack_size)
> +{
> +	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
> +	if (amdgpu_sriov_multi_vf_mode(mm->dev->adev)) {
> +		struct v9_mqd *m;
> +
> +		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
> +		m->cp_hqd_pq_doorbell_control |= 1 <<
> +				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
> +	}
> +}
>  static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		   enum kfd_preempt_type type, unsigned int timeout,
>  		   uint32_t pipe_id, uint32_t queue_id)
> @@ -880,7 +898,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  		mqd->is_occupied = kfd_is_occupied_cp;
>  		mqd->get_checkpoint_info = get_checkpoint_info;
>  		mqd->checkpoint_mqd = checkpoint_mqd;
> -		mqd->restore_mqd = restore_mqd;
>  		mqd->mqd_size = sizeof(struct v9_mqd);
>  		mqd->mqd_stride = mqd_stride_v9;
>  #if defined(CONFIG_DEBUG_FS)
> @@ -892,12 +909,14 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  			mqd->init_mqd = init_mqd_v9_4_3;
>  			mqd->load_mqd = load_mqd_v9_4_3;
>  			mqd->update_mqd = update_mqd_v9_4_3;
> +			mqd->restore_mqd = restore_mqd_v9_4_3;
>  			mqd->destroy_mqd = destroy_mqd_v9_4_3;
>  			mqd->get_wave_state = get_wave_state_v9_4_3;
>  		} else {
>  			mqd->init_mqd = init_mqd;
>  			mqd->load_mqd = load_mqd;
>  			mqd->update_mqd = update_mqd;
> +			mqd->restore_mqd = restore_mqd;
>  			mqd->destroy_mqd = kfd_destroy_mqd_cp;
>  			mqd->get_wave_state = get_wave_state;
>  		}

Better to keep below replacements + addition of new API as a separate
patch (1/2). In 2/2, you may take care of MQD related changes.

Thanks,
Lijo

> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index e8ae7681bf0a..9d8119d91f1f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2009,7 +2009,7 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
>  	/* Enable pp_od_clk_voltage node for gc 9.4.3 SRIOV/BM support */
>  	if (gc_ver == IP_VERSION(9, 4, 3) ||
>  	    gc_ver == IP_VERSION(9, 4, 4)) {
> -		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +		if (amdgpu_sriov_multi_vf_mode(adev))
>  			*states = ATTR_STATE_UNSUPPORTED;
>  		return 0;
>  	}
> @@ -2044,7 +2044,7 @@ static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_
>  	 * setting should not be allowed from VF if not in one VF mode.
>  	 */
>  	if (gc_ver >= IP_VERSION(10, 0, 0) ||
> -	    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))) {
> +	    (amdgpu_sriov_multi_vf_mode(adev))) {
>  		dev_attr->attr.mode &= ~S_IWUGO;
>  		dev_attr->store = NULL;
>  	}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8ca793c222ff..b4bdad79221e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1825,7 +1825,7 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
> +	if (amdgpu_sriov_multi_vf_mode(adev)) {
>  		smu->pm_enabled = false;
>  		return 0;
>  	}
> @@ -2048,7 +2048,7 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  	int i, ret;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return 0;
>  
>  	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> @@ -2116,7 +2116,7 @@ static int smu_suspend(struct amdgpu_ip_block *ip_block)
>  	int ret;
>  	uint64_t count;
>  
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return 0;
>  
>  	if (!smu->pm_enabled)
> @@ -2152,7 +2152,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct smu_context *smu = adev->powerplay.pp_handle;
>  
> -	if (amdgpu_sriov_vf(adev)&& !amdgpu_sriov_is_pp_one_vf(adev))
> +	if (amdgpu_sriov_multi_vf_mode(adev))
>  		return 0;
>  
>  	if (!smu->pm_enabled)

