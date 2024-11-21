Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7CCD75BC8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 07:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E95810E88E;
	Thu, 21 Nov 2024 07:46:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrazpnhX";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1C510E88E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 07:46:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPdli06jsn2svKdh6lM1gKGt0LsWjh3SSmU8k2+Q/6Pox0VKgIiVpe0bir7knrZR8HjeNl6Q46JILWL0zGubRTJnrugMjE7zRfHDF8tdIp7TRmKd2vYPiLQ+CQ/87n0JdpgQcUIZ/xr42unjCMSadt8bSTekIca5pYUakakNcet9TY+guOU9u2jUsqoYpqx1LZX1coKA9y+EwXkO82gG6m3ngZWefkUd9KP3aHRQntbwgTPjaK/0f2/oPbHhJnIZmPhK27BZv22Nb8mKXdAKX2fGCF47PTJjhHbmbXFZwC7obYwpAeeDs2nIaO8gLnQD9avTg7tVHKw3eB9rv3ttrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUBZQ7aLeym+npphbEhW/jzAQ8rgc2xkxB3027y9Tg4=;
 b=InaCBA0Sl0cPxljo/jcky7ZAbJygdDl8JFHraEgQ3GXD7gXJIsG6hAALT/sXFGX+YBzbuPxoPIPch2uany60/vMpOjGFhdktxAVF7hOt8feBNvFCTpgu0e57cBYZ1Z6AjrLK97QvQEU1KkVvBcoH+ikw67ZEecL3K/GD66m3XpSLj0oZwu+IoWRSpRLpaLsTn0IXsYqqss+o1CjXtOPbLkrEknmjfroefgmvieNavG72ACIlG9X3o43/W8lg0hN3JWvGgSmNn2yzMEd091eryjHAQ8Ff7cWOxyhOGb/npHNEpflbHhCQNTYOjcCAI4oMQ14esfGl5hJNQZtX4BBHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUBZQ7aLeym+npphbEhW/jzAQ8rgc2xkxB3027y9Tg4=;
 b=CrazpnhXpff8z015bkpmJ6x7bGH1XQevxNTJ3te9CSeXh5fOV3s1QmnH6cWYeD0VSXZV+zRbFMlOyr01y5F/+oC6dWgzQ1u9gSGYeKwB3zVTrouNN4eriUM9ou/rjsOBhHZugG/T5Qy+07fpIdSh498QlZgtMEJMAm7KnogaLg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Thu, 21 Nov 2024 07:46:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8182.013; Thu, 21 Nov 2024
 07:46:50 +0000
Message-ID: <7a5a9fc3-17a0-41a0-8e78-b74652629ee0@amd.com>
Date: Thu, 21 Nov 2024 13:16:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] drm/amdgpu/vcn2.5: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241113214453.17081-1-alexander.deucher@amd.com>
 <20241113214453.17081-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241113214453.17081-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2c) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 61acccf1-5421-43e3-fffc-08dd0a00a8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDArSElCcEtlbldXbHNCdjJSdk5vcThBRlNqejFwd0Q2d2dPdUZUblZWM2JJ?=
 =?utf-8?B?bjBERTBGc1NqT3BUY0FFZlA2U1Jic3dkdUVmOFNQSWh1MWdNQTBtdlZPdG5R?=
 =?utf-8?B?aDdnV3JDd3REK1pwMVNLMDV6VjErU2VSWkJRejB1bXN3RTljaW9oNnFmeXE1?=
 =?utf-8?B?V3BjaW5YTEFJdTJoTnFZY1dqUExPRWgyTHBWYllXY2kva3d2am5ZYkpMZ284?=
 =?utf-8?B?bGIrRkE3OFlvRVlYMHVnTEQ5YjFUaStoV3hWcUwwbGtJMzd6YXJsTHozVi90?=
 =?utf-8?B?UU5vRWxBUEE5eWNXa252STJaTmxsanVmVzF1c3VRLzQzUHd2djB1Q2ZqMXlJ?=
 =?utf-8?B?ZmRLYWZRSmg5dHR5dUgwUEV3bC84ZmlCdURWbEwyaEtyZXYyZElUWEZHdi9D?=
 =?utf-8?B?V1B6eEs0Nkc1TE9aY0lHdSttSm1JRGxVcHYwVk9UcTZSUFlOYnIxNHo5WTEz?=
 =?utf-8?B?STB5emxYMzlneDRhMWpsdk1jenVEaERaK1U1Zlhrc1BZL2NxRzNUZ1p6VThy?=
 =?utf-8?B?R05FeE01N2N0VjQyYWs0NU1VY0drTjhHVmhTa0tJdkpLaGp5WlVEWk52RXlq?=
 =?utf-8?B?YkVQd2FtV3NwZ2xmcjgxUEpUV0NMclhEZ0twZEczdVZ2a2djZUZ6TmtWRmJU?=
 =?utf-8?B?ZDRWQzJsZk0wbUY2ODFKc05OUStnVTZrcDkwUDdMeEVHdS93OFNTV0I2aGxx?=
 =?utf-8?B?eDcxS3oxT1lXUkhmMWxTRUFJUGh4ZG1kenF5L3NXWDI1ZStSRkdwT0ZQekVF?=
 =?utf-8?B?eWJoMGZCVlpNd05IeTdNZS8zOXRFdGFJd0p6RG5veVJ3UlR3bmszOHl5RVZz?=
 =?utf-8?B?ZE1nZjdEQjE2NjV1MkQzTlNCVE5YQjNBd2VJQjB6djREaThnS2dqL2FDLzNa?=
 =?utf-8?B?MGJYNjN5QkR0Tld2bUptaU1zLzdva20xYTNZMkJPLy92eGNXd2YxUnQ1bldN?=
 =?utf-8?B?VVppaEFmQnltL3VDSGNmenVZZWRUc1dZK2prWUhlTGU0Y3BLdUtITVZHdW82?=
 =?utf-8?B?cEVPWmRaak1iU1NhdDBxb2RodzQ1cXhrMzkvYTZ4aWxVOERPcXZkUHNsMHNs?=
 =?utf-8?B?QlZ3aDFCK05oSDJmeDlscVBRM0tzcTlQZG9pSGlzN0dZSUZZT0hlWEg3bFE1?=
 =?utf-8?B?YW10YnZ2K0dxVDNJSWtZNFJUZWVwZ0duSVI3TWVxTmp2UFUrVEJudGhxeHZ4?=
 =?utf-8?B?ZXd1M2p5NitCZXptSlU4WUJvV1RKaWFVN0ZzUExwcnVFTk9WUklQY052ZlNC?=
 =?utf-8?B?R0doT1NNMU1YL05VZHBuS2VKT21KcFBpaTU4ZUdBSmY4cDQzVWQrbFAvVSsw?=
 =?utf-8?B?T0RaR0t1aU9LR0RUOUlCK01YVkFadmN1dnBWSm42bTJLYWszNDhTMDBCbnUy?=
 =?utf-8?B?TDczUTBXL0Zoc2doSFZXVk5ZNkRPME43SURtTVJlNm9UV2tQeUlHM1Erem0v?=
 =?utf-8?B?MGViZ3Y4enF6dXlxOVVBY1JZWGtvL3lnbXpHWUIvRHNiV2FkdGNKdWtxZ1BS?=
 =?utf-8?B?dWxoTDJ6SWhwSFVHVzdmZktodWZFZ0dHeU1uTHJtNDZOUk53U2RGd2FCd0Qv?=
 =?utf-8?B?TVJzbnhCajZweGNlMU92Z0lONDVMKzhQYXdZMDd5ZlhDaHZPLzhRcndCeHc1?=
 =?utf-8?B?dlJVU2RrWHhoak1EdGlHeUdPekhMbk9EZzA1dVF2UkM2aTN5Yk9tSVRNbWtH?=
 =?utf-8?B?L2ZPdHdmYk1zSWo0RHhoT3AvTE56cUFEVEpiQlF0ZEhOZ2hEdW1BTTlGUEFl?=
 =?utf-8?Q?Zx0N97MW2NI/lar1bM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDgvVU1UcUZ3TjFscmowMEhYUnAyY2svSzZHZDhlaDlFaWlNZkh4TDBrM0dq?=
 =?utf-8?B?WnVNUW01Z0lJNVU1UzhDY2paakV5RmVsOWYrbjRMOENRMVU1WDN3b3BET210?=
 =?utf-8?B?emNsK2U2aFVrRjJiTEw3OVBtNC9XVmh4SnlGNWtVMFdNYWxrQnd2U0VGSkY4?=
 =?utf-8?B?bWdPT2FzaXY4dUdsdnZFYyt0d2FoN29QMVVlSDJ5V2FJR0IwS1g1Z3ArQ0Z1?=
 =?utf-8?B?K0wyZEFrbUlzVW5Jdy9EOFVJTXBpWDNYcnVYSGdsSmxaK2hpeWkra3VVTjdu?=
 =?utf-8?B?QnRDaGhNc29zaFYxUXpmS1NBVmowREI0WXlyVFFVc2srVVhjb0VRR1NUV0Zi?=
 =?utf-8?B?RlUrMlUyV2k5bkdMalNzd25JUlg4ZzRWZlhRbXpFUFpWSGs0MlNFMkRkYzdJ?=
 =?utf-8?B?ZFdxaVhGUzVVNUVtUlBsZi9iRCtQazFGRGt1dXpacnUvNGlnUDVQS2cwdk90?=
 =?utf-8?B?VXNkdUxSZlZmQngzV2JyellSQktaOHd5WUN6eWYxRkR0QW1rSjV5aHYxckln?=
 =?utf-8?B?ZVI5WlRKUlpodnlSdnVIRXA4VTdTdkhOeXhZMlNqUzJtSllBU0RiaUFlS0o2?=
 =?utf-8?B?OERpOFlxaDZjeE1CTWh6YXRiaG91R3Z4YURxb1ZQRDlSV3pkb1FYeENVUGZu?=
 =?utf-8?B?TmVLeFB3cGErTmt5MmdKeW92YU1wVGdDRmhyL0pYbWVMOElXdVo4TWEvZGtV?=
 =?utf-8?B?ek1ORFdVQ20zc04vUVBKSlVrU1RpYXhrSndQd3NyVlZOMWxERGNDcGdaalNy?=
 =?utf-8?B?NjB1Zm5FYnNqVmQzUEExek1CS0hJQlc4VHp3dDNrKzI4ZkhtRDFxZ0dDMzZR?=
 =?utf-8?B?RHpQaXRZemdPZ0xZajU0c0JBNnFXUUxWNUdVRGs1QzkzOXNJRXhmaDNnR1JS?=
 =?utf-8?B?M29NbndBVFJDc0lFbnJOVE8vN2VpQ0NscitUWmlnLzFSQjVrVDlqczlDOXJD?=
 =?utf-8?B?V1dnTFduQXNsOWVpZUFqUktNaWpGK1RKSUxJUjFSckwxTldWYTc1a3V5MzJw?=
 =?utf-8?B?cjJ6UUV0S2RHdVpEWVlEaHIrMU9RQmlOTlFreHJZeFJrTXJVcVNqV0VHSm1k?=
 =?utf-8?B?TUsyT0RaampiSzhQVHFVdkNtanBGOFZVYWY4K3F0L3JHOFRTRDVRY1FKSTlF?=
 =?utf-8?B?bitWcDhxYkFNczIwN2ZBbElvTHRBMXI0WTBYUWIyMFRYaldIakVzMUxqL2Nl?=
 =?utf-8?B?Y3pJRzRMZjhXUVJ3K3p1RnBrb2trQVBiY3YwRm9EUE43WlBSR21Ga3Z6c3h3?=
 =?utf-8?B?Mm1CblBYa2c2amYyV0piSVZyZ0Zod2lIUzZQZWtLbE12cmZJejFJcW92MDYw?=
 =?utf-8?B?cDN4NWdjYW16N1ZrR3g5Mkt4R2FqT204NTQ0ZThaUXNheDlzRjBFNXpOT3VF?=
 =?utf-8?B?bFVJN2tFczQ5UlFpTGlWME81S2lhZkYxekVsU2hTUzdBSlEvM2NNSDBJUGxX?=
 =?utf-8?B?eFgrRk1ESHdNeE15Z2ducnBaeXZteTNURFlJODhuRi9yWER6NHVObVY4aXBT?=
 =?utf-8?B?eTNLcmtEcHA3MXBWWE5KMEZUYWFpaE9kelR4a0RYeWZ5bW5GbEwvVTJrajNN?=
 =?utf-8?B?OTFXQXpwbitNWDNuUFVBR090RkJHWVkwaWpvaDlWQXI1bUdCaHB1NlZZQW13?=
 =?utf-8?B?UWpLd2RGRTd4WlhNZmR5M3B6SFlMOXNObDM1MzRRRVpnZDJPOW5IbVhOeUVT?=
 =?utf-8?B?OXF6TVo1SWR0MGVOV0dERWhpSTBhcHBQVmp1QkFqRkd0RDVoMU80SHRzMWJ0?=
 =?utf-8?B?M0p4YVRWWVk3OTV6T3hiQkdUWVNDemorZkJFWmFnSGhzQmtVL2l2NU1JUDVB?=
 =?utf-8?B?cVo2RENpMWdaVjRaRDl3dnNrR29DYktEUmJlK0J4c2pEcWd5L0tubTRkUjNn?=
 =?utf-8?B?YmwvY0lvVEsrK2ZYdkdQY1ozS2VWK3BCL3VaMlhjcTFRVFIrN2IwdkpIdHBM?=
 =?utf-8?B?STN0Y1NPSEswOWRPaGswb2xlaWJmaUtiWnNESzU4RkpMSGZYSk4wck1xSTAv?=
 =?utf-8?B?TkFzbnA3djdkdm8vb0IxVDZDbmU5cjlvMGlvazlMMmprbnNSR1MvcnhTWFRh?=
 =?utf-8?B?MFRGUS8xeEMxbk5LWVRKK09wYTJuODZqVDNycGNKbTdEUkgvQlZadE9NMFRr?=
 =?utf-8?Q?gD0QFzazk+8GwbaZkjbDypdo0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61acccf1-5421-43e3-fffc-08dd0a00a8bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 07:46:50.7093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJbWva2dIkLf39lBjgDSylp/UNARp0HbVmRSsdnRqoA+Yuovi6TaO61Pe4hzoiQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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



On 11/14/2024 3:14 AM, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 841 +++++++++++++-------------
>  1 file changed, 411 insertions(+), 430 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b518202955ca..b9be304aa294 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -452,64 +452,62 @@ static int vcn_v2_5_resume(struct amdgpu_ip_block *ip_block)
>   * vcn_v2_5_mc_resume - memory controller programming
>   *
>   * @adev: amdgpu_device pointer
> + * @i: instance to resume
>   *
>   * Let the VCN memory controller know it's offsets
>   */
> -static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
> +static void vcn_v2_5_mc_resume(struct amdgpu_device *adev, int i)

For patches 5-10, would be better if the function templates are made like

vcn_xyz_func(amdgpu_vcn_inst *vcn_inst)
{
	adev = vcn_inst->vcn->adev or vcn_inst->adev;
	i = vcn_inst->inst;
}

That aside, patches look good to me.

Thanks,
Lijo
>  {
>  	uint32_t size;
>  	uint32_t offset;
> -	int i;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
>  
> -		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
> -		/* cache window 0: fw */
> -		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> -				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> -				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
> -			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
> -			offset = 0;
> -		} else {
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> -				lower_32_bits(adev->vcn.inst[i].gpu_addr));
> -			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> -				upper_32_bits(adev->vcn.inst[i].gpu_addr));
> -			offset = size;
> -			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
> -				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
> -		}
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
>  
> -		/* cache window 1: stack */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
> -			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
> -			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
> -
> -		/* cache window 2: context */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
> -			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
> -			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
> -
> -		/* non-cache window */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
> -			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
> -			upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
> -		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
> -			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
> +	size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
> +	/* cache window 0: fw */
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
> +		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
> +		offset = 0;
> +	} else {
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
> +			     lower_32_bits(adev->vcn.inst[i].gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
> +			     upper_32_bits(adev->vcn.inst[i].gpu_addr));
> +		offset = size;
> +		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
> +			     AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
>  	}
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
> +
> +	/* cache window 1: stack */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
> +		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
> +		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
> +
> +	/* cache window 2: context */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
> +		     lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
> +		     upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
> +
> +	/* non-cache window */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
> +		     lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
> +		     upper_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
> +		     AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
>  }
>  
>  static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> @@ -612,117 +610,115 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
>   * vcn_v2_5_disable_clock_gating - disable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> + * @i: instance to disable clockgating on
>   *
>   * Disable clock gating for VCN block
>   */
> -static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev, int i)
>  {
>  	uint32_t data;
> -	int i;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* UVD disable CGC */
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -		else
> -			data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> -		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
> -		data &= ~(UVD_CGC_GATE__SYS_MASK
> -			| UVD_CGC_GATE__UDEC_MASK
> -			| UVD_CGC_GATE__MPEG2_MASK
> -			| UVD_CGC_GATE__REGS_MASK
> -			| UVD_CGC_GATE__RBC_MASK
> -			| UVD_CGC_GATE__LMI_MC_MASK
> -			| UVD_CGC_GATE__LMI_UMC_MASK
> -			| UVD_CGC_GATE__IDCT_MASK
> -			| UVD_CGC_GATE__MPRD_MASK
> -			| UVD_CGC_GATE__MPC_MASK
> -			| UVD_CGC_GATE__LBSI_MASK
> -			| UVD_CGC_GATE__LRBBM_MASK
> -			| UVD_CGC_GATE__UDEC_RE_MASK
> -			| UVD_CGC_GATE__UDEC_CM_MASK
> -			| UVD_CGC_GATE__UDEC_IT_MASK
> -			| UVD_CGC_GATE__UDEC_DB_MASK
> -			| UVD_CGC_GATE__UDEC_MP_MASK
> -			| UVD_CGC_GATE__WCB_MASK
> -			| UVD_CGC_GATE__VCPU_MASK
> -			| UVD_CGC_GATE__MMSCH_MASK);
> -
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
> -
> -		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -			| UVD_CGC_CTRL__SYS_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MODE_MASK
> -			| UVD_CGC_CTRL__MPEG2_MODE_MASK
> -			| UVD_CGC_CTRL__REGS_MODE_MASK
> -			| UVD_CGC_CTRL__RBC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -			| UVD_CGC_CTRL__IDCT_MODE_MASK
> -			| UVD_CGC_CTRL__MPRD_MODE_MASK
> -			| UVD_CGC_CTRL__MPC_MODE_MASK
> -			| UVD_CGC_CTRL__LBSI_MODE_MASK
> -			| UVD_CGC_CTRL__LRBBM_MODE_MASK
> -			| UVD_CGC_CTRL__WCB_MODE_MASK
> -			| UVD_CGC_CTRL__VCPU_MODE_MASK
> -			| UVD_CGC_CTRL__MMSCH_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		/* turn on */
> -		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
> -		data |= (UVD_SUVD_CGC_GATE__SRE_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_MASK
> -			| UVD_SUVD_CGC_GATE__SMP_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_MASK
> -			| UVD_SUVD_CGC_GATE__SRE_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_H264_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> -			| UVD_SUVD_CGC_GATE__SCLR_MASK
> -			| UVD_SUVD_CGC_GATE__UVD_SC_MASK
> -			| UVD_SUVD_CGC_GATE__ENT_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> -			| UVD_SUVD_CGC_GATE__SITE_MASK
> -			| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> -			| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> -			| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> -			| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> -			| UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> -		data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
> +	/* UVD disable CGC */
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	else
> +		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
> +	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_GATE);
> +	data &= ~(UVD_CGC_GATE__SYS_MASK
> +		  | UVD_CGC_GATE__UDEC_MASK
> +		  | UVD_CGC_GATE__MPEG2_MASK
> +		  | UVD_CGC_GATE__REGS_MASK
> +		  | UVD_CGC_GATE__RBC_MASK
> +		  | UVD_CGC_GATE__LMI_MC_MASK
> +		  | UVD_CGC_GATE__LMI_UMC_MASK
> +		  | UVD_CGC_GATE__IDCT_MASK
> +		  | UVD_CGC_GATE__MPRD_MASK
> +		  | UVD_CGC_GATE__MPC_MASK
> +		  | UVD_CGC_GATE__LBSI_MASK
> +		  | UVD_CGC_GATE__LRBBM_MASK
> +		  | UVD_CGC_GATE__UDEC_RE_MASK
> +		  | UVD_CGC_GATE__UDEC_CM_MASK
> +		  | UVD_CGC_GATE__UDEC_IT_MASK
> +		  | UVD_CGC_GATE__UDEC_DB_MASK
> +		  | UVD_CGC_GATE__UDEC_MP_MASK
> +		  | UVD_CGC_GATE__WCB_MASK
> +		  | UVD_CGC_GATE__VCPU_MASK
> +		  | UVD_CGC_GATE__MMSCH_MASK);
> +
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_GATE, data);
> +
> +	SOC15_WAIT_ON_RREG(VCN, i, mmUVD_CGC_GATE, 0,  0xFFFFFFFF);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +		  | UVD_CGC_CTRL__SYS_MODE_MASK
> +		  | UVD_CGC_CTRL__UDEC_MODE_MASK
> +		  | UVD_CGC_CTRL__MPEG2_MODE_MASK
> +		  | UVD_CGC_CTRL__REGS_MODE_MASK
> +		  | UVD_CGC_CTRL__RBC_MODE_MASK
> +		  | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +		  | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +		  | UVD_CGC_CTRL__IDCT_MODE_MASK
> +		  | UVD_CGC_CTRL__MPRD_MODE_MASK
> +		  | UVD_CGC_CTRL__MPC_MODE_MASK
> +		  | UVD_CGC_CTRL__LBSI_MODE_MASK
> +		  | UVD_CGC_CTRL__LRBBM_MODE_MASK
> +		  | UVD_CGC_CTRL__WCB_MODE_MASK
> +		  | UVD_CGC_CTRL__VCPU_MODE_MASK
> +		  | UVD_CGC_CTRL__MMSCH_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	/* turn on */
> +	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE);
> +	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_MASK
> +		 | UVD_SUVD_CGC_GATE__SMP_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_MASK
> +		 | UVD_SUVD_CGC_GATE__SRE_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_H264_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
> +		 | UVD_SUVD_CGC_GATE__SCLR_MASK
> +		 | UVD_SUVD_CGC_GATE__UVD_SC_MASK
> +		 | UVD_SUVD_CGC_GATE__ENT_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
> +		 | UVD_SUVD_CGC_GATE__SITE_MASK
> +		 | UVD_SUVD_CGC_GATE__SRE_VP9_MASK
> +		 | UVD_SUVD_CGC_GATE__SCM_VP9_MASK
> +		 | UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
> +		 | UVD_SUVD_CGC_GATE__SDB_VP9_MASK
> +		 | UVD_SUVD_CGC_GATE__IME_HEVC_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_GATE, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> +	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +		  | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
>  			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> -	}
> +		  | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
>  }
>  
>  static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
> @@ -774,65 +770,63 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
>  }
>  
>  /**
> - * vcn_v2_5_enable_clock_gating - enable VCN clock gating
> + * vcn_v2_5_enable_clock_gating_inst - enable VCN clock gating
>   *
>   * @adev: amdgpu_device pointer
> + * @i: instance to enable clockgating on
>   *
>   * Enable clock gating for VCN block
>   */
> -static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev, int i)
>  {
>  	uint32_t data = 0;
> -	int i;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* enable UVD CGC */
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> -			data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -		else
> -			data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> -		data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> -		data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> -		data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> -			| UVD_CGC_CTRL__SYS_MODE_MASK
> -			| UVD_CGC_CTRL__UDEC_MODE_MASK
> -			| UVD_CGC_CTRL__MPEG2_MODE_MASK
> -			| UVD_CGC_CTRL__REGS_MODE_MASK
> -			| UVD_CGC_CTRL__RBC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_MC_MODE_MASK
> -			| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> -			| UVD_CGC_CTRL__IDCT_MODE_MASK
> -			| UVD_CGC_CTRL__MPRD_MODE_MASK
> -			| UVD_CGC_CTRL__MPC_MODE_MASK
> -			| UVD_CGC_CTRL__LBSI_MODE_MASK
> -			| UVD_CGC_CTRL__LRBBM_MODE_MASK
> -			| UVD_CGC_CTRL__WCB_MODE_MASK
> -			| UVD_CGC_CTRL__VCPU_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> -
> -		data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> -		data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> -			| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> -		WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
> +	/* enable UVD CGC */
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> +		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	else
> +		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_CGC_CTRL);
> +	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_CM_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_IT_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_DB_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_MP_MODE_MASK
> +		 | UVD_CGC_CTRL__SYS_MODE_MASK
> +		 | UVD_CGC_CTRL__UDEC_MODE_MASK
> +		 | UVD_CGC_CTRL__MPEG2_MODE_MASK
> +		 | UVD_CGC_CTRL__REGS_MODE_MASK
> +		 | UVD_CGC_CTRL__RBC_MODE_MASK
> +		 | UVD_CGC_CTRL__LMI_MC_MODE_MASK
> +		 | UVD_CGC_CTRL__LMI_UMC_MODE_MASK
> +		 | UVD_CGC_CTRL__IDCT_MODE_MASK
> +		 | UVD_CGC_CTRL__MPRD_MODE_MASK
> +		 | UVD_CGC_CTRL__MPC_MODE_MASK
> +		 | UVD_CGC_CTRL__LBSI_MODE_MASK
> +		 | UVD_CGC_CTRL__LRBBM_MODE_MASK
> +		 | UVD_CGC_CTRL__WCB_MODE_MASK
> +		 | UVD_CGC_CTRL__VCPU_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_CGC_CTRL, data);
> +
> +	data = RREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL);
> +	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__UVD_SC_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__IME_MODE_MASK
> +		 | UVD_SUVD_CGC_CTRL__SITE_MODE_MASK);
> +	WREG32_SOC15(VCN, i, mmUVD_SUVD_CGC_CTRL, data);
>  }
>  
>  static void vcn_v2_6_enable_ras(struct amdgpu_device *adev, int inst_idx,
> @@ -1006,197 +1000,185 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>  	return 0;
>  }
>  
> -static int vcn_v2_5_start(struct amdgpu_device *adev)
> +static int vcn_v2_5_start(struct amdgpu_device *adev, int i)
>  {
> +	volatile struct amdgpu_fw_shared *fw_shared =
> +		adev->vcn.inst[i].fw_shared.cpu_addr;
>  	struct amdgpu_ring *ring;
>  	uint32_t rb_bufsz, tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>  
> -		/* disable register anti-hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>  
> -		/* set uvd status busy */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> -	}
> +	/* disable register anti-hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> +		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> +
> +	/* set uvd status busy */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>  
>  	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>  		return 0;
>  
> -	/*SW clock gating */
> -	vcn_v2_5_disable_clock_gating(adev);
> +	/* SW clock gating */
> +	vcn_v2_5_disable_clock_gating(adev, i);
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* setup mmUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> -		tmp &= ~0xff;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup mmUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup mmUVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -	}
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>  
> -	vcn_v2_5_mc_resume(adev);
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> +	/* setup mmUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> +	tmp &= ~0xff;
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup mmUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> +		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> +		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup mmUVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> +		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +	vcn_v2_5_mc_resume(adev, i);
>  
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +	WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
>  
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>  
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		for (k = 0; k < 10; ++k) {
> -			uint32_t status;
> -
> -			for (j = 0; j < 100; ++j) {
> -				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				if (amdgpu_emu_mode == 1)
> -					msleep(500);
> -				else
> -					mdelay(10);
> -			}
> -			r = 0;
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (k = 0; k < 10; ++k) {
> +		uint32_t status;
> +
> +		for (j = 0; j < 100; ++j) {
> +			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>  			if (status & 2)
>  				break;
> +			if (amdgpu_emu_mode == 1)
> +				msleep(500);
> +			else
> +				mdelay(10);
> +		}
> +		r = 0;
> +		if (status & 2)
> +			break;
>  
> -			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__BLK_RST_MASK,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			 UVD_VCPU_CNTL__BLK_RST_MASK,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		mdelay(10);
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>  
> -			mdelay(10);
> -			r = -1;
> -		}
> +		mdelay(10);
> +		r = -1;
> +	}
>  
> -		if (r) {
> -			DRM_ERROR("VCN decode not responding, giving up!!!\n");
> -			return r;
> -		}
> +	if (r) {
> +		DRM_ERROR("VCN decode not responding, giving up!!!\n");
> +		return r;
> +	}
>  
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>  
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>  
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>  
> -		ring = &adev->vcn.inst[i].ring_dec;
> -		/* force RBC into idle state */
> -		rb_bufsz = order_base_2(ring->ring_size);
> -		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
> +	ring = &adev->vcn.inst[i].ring_dec;
> +	/* force RBC into idle state */
> +	rb_bufsz = order_base_2(ring->ring_size);
> +	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>  
> -		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> -		/* program the RB_BASE for ring buffer */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -			lower_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -			upper_32_bits(ring->gpu_addr));
> +	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
> +	/* program the RB_BASE for ring buffer */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +		     lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +		     upper_32_bits(ring->gpu_addr));
>  
> -		/* Initialize the ring buffer's read and write pointers */
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> +	/* Initialize the ring buffer's read and write pointers */
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>  
> -		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> -				lower_32_bits(ring->wptr));
> -		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
> +	ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> +		     lower_32_bits(ring->wptr));
> +	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
>  
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> -
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> -		ring = &adev->vcn.inst[i].ring_enc[1];
> -		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> -		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
> -	}
> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
> +
> +	fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
> +	ring = &adev->vcn.inst[i].ring_enc[1];
> +	WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
>  
>  	return 0;
>  }
> @@ -1425,72 +1407,66 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>  	return 0;
>  }
>  
> -static int vcn_v2_5_stop(struct amdgpu_device *adev)
> +static int vcn_v2_5_stop(struct amdgpu_device *adev, int i)
>  {
>  	uint32_t tmp;
> -	int i, r = 0;
> +	int r;
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v2_5_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v2_5_stop_dpg_mode(adev, i);
>  
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>  
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>  
> -		/* block LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> +	/* block LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>  
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>  
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>  
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>  
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>  
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
> +	/* clear status */
> +	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>  
> -		vcn_v2_5_enable_clock_gating(adev);
> +	vcn_v2_5_enable_clock_gating(adev, i);
>  
> -		/* enable register anti-hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> -			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> -			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> -	}
> +	/* enable register anti-hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
> +		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
> +		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>  
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>  
>  	return 0;
>  }
> @@ -1811,16 +1787,19 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	bool enable = (state == AMD_CG_STATE_GATE);
> +	int i;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> -	if (enable) {
> -		if (!vcn_v2_5_is_idle(adev))
> -			return -EBUSY;
> -		vcn_v2_5_enable_clock_gating(adev);
> -	} else {
> -		vcn_v2_5_disable_clock_gating(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (enable) {
> +			if (!vcn_v2_5_is_idle(adev))
> +				return -EBUSY;
> +			vcn_v2_5_enable_clock_gating(adev, i);
> +		} else {
> +			vcn_v2_5_disable_clock_gating(adev, i);
> +		}
>  	}
>  
>  	return 0;
> @@ -1830,20 +1809,22 @@ static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  					  enum amd_powergating_state state)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>  
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> -	if(state == adev->vcn.cur_state)
> +	if (state == adev->vcn.cur_state)
>  		return 0;
>  
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_5_stop(adev);
> -	else
> -		ret = vcn_v2_5_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v2_5_stop(adev, i);
> +		else
> +			ret |= vcn_v2_5_start(adev, i);
> +	}
>  
> -	if(!ret)
> +	if (!ret)
>  		adev->vcn.cur_state = state;
>  
>  	return ret;
