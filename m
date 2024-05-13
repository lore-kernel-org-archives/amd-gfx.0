Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD813C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 10:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FF510E636;
	Mon, 13 May 2024 10:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pbDHhp2k";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BE710E636
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 10:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFHeznVRJt2Apc0BcwaAuFH16ixiD5fSB5pecSvVAs9BiTNdeJYhPN0erQ2xwmxuKR9yY/ojwxfCnYyUd1waxJsXwQ4u/Ql5p0xV+No+JLa/ERzZAPEGfm3pAYw0cEL42Q00jaOg4wsTszq+LAz5FjiVQgL71wt3dQ9tizkZhFwBMah1//q8uRDtRRArZ70Z6HjquZQCTainTTaJiBPcZvqgGyAVczPX79TuIs82fU6ofpjNsrycTSUvXd/AJIBUwPk1mW4B+VtCw1Rnw3R9nBi6vMykNe3Q4j7MBaxDsTnU+t+2DoVDESAOpH05qSz9lpTdEqOdDnM1yAw4PBJCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKBcSO1XIEVYf+Vd/2WOGdd2K6wyJdEiV6QopKQ5u34=;
 b=mJ6FwVCIBM4Mo+zzjjuH+xgiOkJn16g0anu57gWJGiAQ1Dvg+TGMIwxy6kWysvNvus/BNZTgHe8xGerzVsQAycgfHZg2oQ1/lzPGtEXoINP0KH411juRiN+faV1WN1tSaZ7A/KTUAMintVA8ARf4gHwQ68ThOA+Lh0uKczt60q9PakVsw69DJLjqbdI5EWcr0mwriy6Ejt3duQ3FrxYq6qPjN8I6PC+nGhSMFinr5CVGf68A95iUWgGyiyG4dh8joUlqp6++pzVhxyRYGiIIV4W+503MOSBcoCQLIUSyPZXLakvhGJ1CKL/6/GoCayJPmPLcilAG3tNI0E0G70RwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKBcSO1XIEVYf+Vd/2WOGdd2K6wyJdEiV6QopKQ5u34=;
 b=pbDHhp2kWbnEtCrG+fy0/UjYYwQhroC+TxBsP2pPKv9WiUB0kCmC4z5pR+LdZVubxzfuzu8dmmpvVzww8KnjhNBtpxZs0N68kHsFn3yrLxy/IByGi9ckd5l7tRu0luw2QOXR8IASOIMaR28Bgp52O5uUBnxakDLhi36cPECnGjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8427.namprd12.prod.outlook.com (2603:10b6:510:242::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 10:58:00 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:58:00 +0000
Message-ID: <bab7e769-0c47-49b3-b406-fd20f54ccfc4@amd.com>
Date: Mon, 13 May 2024 16:27:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] drm/amd/pm: check specific index for smu13
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-9-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240510025038.3488381-9-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::49) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3856bba5-2b72-43c3-308f-08dc733b8dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE9QdVYxcmhnamlGZTBYZVZkd0tJcG4zdldaSXhnc0lxZnRHeGxGVHZoV1M2?=
 =?utf-8?B?QVJQYTdoRHJEMmZwTEdSaGoydW9yMlpLQ1R2Nk9GNTZodGRnUDAwYXNJMko5?=
 =?utf-8?B?Q0FNWHBmSUpoYlRDZ2NldjFPcUY0T0VWMEw3UmRJOFg3ZWp5cjdqSmVZdDJI?=
 =?utf-8?B?T1BpeGsyMGIrcERYNEdTV0x0T1g1YllZSDA2aWJxQjRyd0FOOEx1dzZoaEhW?=
 =?utf-8?B?OW42d0VUNzRKTjQ1MVlnbGRlczB5YXRaOTlVcFFVYUtHazVqcVZ6KzZTYnhH?=
 =?utf-8?B?alZUMGZuUVNmNk9BZXZtNWUyL3FFZWxqZ05OYVMrbTJMeE53RU4xWWZ3ZmUx?=
 =?utf-8?B?ak5EWlpSZ09OTUpxUDJCRFNGeVhxODY0bHBlN2FqUnB4TitpaEVtbmg4Tkda?=
 =?utf-8?B?YjREK0IwZmIzQnhRT2xqV09GUkh3UFhLOHMwTEtab3pqVzhpdHZNdXg5ZURz?=
 =?utf-8?B?L1FFOHo5Tnl3eFhaUm5tMEFQakdES3d0c3d0bWZQb1k3M1ZiY1R6eERSWmdH?=
 =?utf-8?B?N0xKUmJ3dHNaSngwcXIxV0lpc2tRSjFLOWYvNWtzSEtwRU1nT00zM1V3dzBy?=
 =?utf-8?B?REFZZ09GWXdQeE9CTkZZeW1yTCtOcy9DbVZaelpCRXdMMGlFa3huc2s1QVg3?=
 =?utf-8?B?bVNMVzUyZG5EZ0J3M1ZoejQ3c2RUUTFqaUtpNml0SkE5R24yUFhDMGpndi82?=
 =?utf-8?B?S1lCTnRaamdBektXQWRqL1Q2eDZhWDJlNjRGRnJFcitXQlF5czNiYXBBeXc1?=
 =?utf-8?B?M0lISzQwOGhoWVVPTFQvUlB3VGplR25wdDN5S01UemZHMkJubWQwS1drMmNn?=
 =?utf-8?B?cVNnRkFYZFN3azVidFBkZ2xBSGVVN2Y3dG1OeU5CcW9HZmN4dXVlNnRralFX?=
 =?utf-8?B?SVdWWWpCRzg4Z3VjVi9hQlZDV0VwSkFGMDZhYmF3NndRZHp0Q3JrRWhBU0dn?=
 =?utf-8?B?bUFJOVRKd0RoZTRXRVIxTUFFcUxoN1o4U3dvd1Z0T1JXVll3anJMdytHYUtS?=
 =?utf-8?B?U3NGK0dTTkE4MHFNN3F2US9YKzJBN2lGOS9POHliY0g1dGtZTHE0YzV2Mnpp?=
 =?utf-8?B?dUtPYUFZdGkwNmVCb1gwWDRWZ3BsZThsemFwdUJ2SFdnczZFaDA4Q2hualJP?=
 =?utf-8?B?aEh6RWFjczJMV0dUeE9pSnlWRzl3WkF5V1F5RDRxZWNXbUNjaXNicHlyODRG?=
 =?utf-8?B?cmtFclJoTjg4NkErZHY4OUZadDcvY0JYNnVuUEphWDNoMEgxWXRvam44UWpu?=
 =?utf-8?B?SVlzdVl2MitBU1hZajZtQXBNNGxLT3JQc3VwaytlSmdnZGFSbnJuSXgrVVk0?=
 =?utf-8?B?eld2MnhlV3Nrc0ZZa1hBdlRuYUVtYkJ6eTh0QjR4VklvdE5KcjZaQTJHcVRS?=
 =?utf-8?B?YlhtSnJ3cDVybk9jcVc1QThkNTkrdXQyS05aSjhRN0tjOE1BS09BRE11Q3FQ?=
 =?utf-8?B?MjQxNVA0cVVxM2wwU1RoUllQU0J4OFpweW84TEdzVlNSdHhWakI2SkRPSTV0?=
 =?utf-8?B?T1BIbVc3cVkwUVpYeGNTTDVpdTBwWGZ0emdsWVZXbFk1KzJVMDlvWmtNQ0lz?=
 =?utf-8?B?eUtJSFZCY08vMnlubWlMaHJOVmNDaVAxWDJDR0NKUVdpeUtQMm51d2ZuNzZL?=
 =?utf-8?B?M1lSMTFaUkowclBwQ1VFanRIeVYyaWZkaDN5cFFrQThBRkhTaWgwcEFHWEFK?=
 =?utf-8?B?UmdXSnlJRm9vRTBmZ1hQaElVUkwrd3pPL0tXTmlnQW9PaGZrOVRNMi9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3AveDB6RHRuZVVIUHdRWDZxdWQ0UGFDOFA1L0hTL2lHa29qNGkrc3NDQk1u?=
 =?utf-8?B?SWs3YUsydjJBNFdkaG94VDkveG9IbFlDMDljTHYxTE5ybUVSTUE0ay9XUnJv?=
 =?utf-8?B?b2FQV2dMNDVDWUN1cTFDSHRXSG8zRTQraU1pWDBIZFVnbUhkWThiNGdNRmly?=
 =?utf-8?B?R2ZIelJMTWczT1Z2U0F0L0RRZ0dnTElCbnpJTmFZOUZLdGNvVFBRZDBTRmlP?=
 =?utf-8?B?bHdmTXNmYkYrcUtYZE83S2cwQjVMbEppTGRxNFV5aTNibUNQTjFlV01yZFpW?=
 =?utf-8?B?TStkMWFIdzZ1WEdxa01TMHNES3dLdU5XdUx3V25HdjJFT0djTUxQa1ZRdVcx?=
 =?utf-8?B?ZXdMczAyci9ZWXZsdE1DclJhaTRENEhYUHNrMHdLa0x0UzZkbmNtUU02ZXRm?=
 =?utf-8?B?WnBnMlE3SlhtR0pOOWdGREJrMXRNcUVXbVFqdTVETDVKN2VISVhidVN0cWpx?=
 =?utf-8?B?QnkwQkxseFNiNW4vaWxGM2NGLyt2WWhuZkZxZzQrcFRRN2VuTXdGKzEzZG90?=
 =?utf-8?B?Ti9seGNBbHB0enZGVnZFYlN0MVozYTJza3FmWEN3K1ZjVGNnb0F3ZVNlbFZL?=
 =?utf-8?B?TThNQnRZbk5oc0U0MWJ0cFVGRDgyZG9rOVM5bTVFWTNqU2Mwem41VENYZTBq?=
 =?utf-8?B?aXFtV1drTENJNFNCRHg1UFNpNGNPRUFHN3V3cnkvNlR3RWZkaFYwUGprQkRk?=
 =?utf-8?B?L25wazB3b0FHcWt2V3FtaGVqSXNSQ2d5c3lQUGoyQ3VKdzR6bjJWaldTV3N3?=
 =?utf-8?B?SUhFRXAzWVg1RzRTR3BvR2ljSXQ1aUVmUklXbHB2SWxUMitZS0Z3TDFETlNa?=
 =?utf-8?B?a25pcGFpRXRSSXRiZnZ2Y3NsT3ZNcjh6MTIxSWlNMVR5MENzV3VrTEdIbU9F?=
 =?utf-8?B?OHF3UW1pc1BLQzIwYTFTTjA5MCtBaGpaN25URnhVOUt1TGNNYVN1VWFsR0xT?=
 =?utf-8?B?c3NsTWFUSFhDNXVRWVYxbTRhb0JVNHBIU2dzeDBNTjZyakcvNGRWRWNTRUN3?=
 =?utf-8?B?eUZNa2hZYnVhL25wRW8rbEFvQitIRTJJNTR4VE8rbVNUZzJFYjZyN0dLeE1N?=
 =?utf-8?B?TzVqOGxUMTZNM0xIVGpHOHJaczhQR2thaXcxUVBmV1dKSWJYUEdCUHNucXFT?=
 =?utf-8?B?YkNJODIxTWtkUk1IeDFvb3p5aDlSeHpxS2dvd3J4ekgrRXBuM1piaU1HcmIv?=
 =?utf-8?B?VUdtd0xaaFFBWDFXWXhhRXlwR1dJcWpHRENaTnNLeFJiKzNXV3Y0OEloc01y?=
 =?utf-8?B?OHBZTWhMQTZIWFdCRkNsMnZlSHlWd1dxc2J0QVFlYURvSXlwT1Y0RnY0aHdT?=
 =?utf-8?B?YnpnVUlSbzB4Q0FjVzFGdjZDNVdaMExtb1M0MCtJRHNyeERxSUFUN01YL2Fl?=
 =?utf-8?B?N2IzSDFNNmFiYmhrSGtMK25oamxKdFZYNWNpOU14Z1RGRjd3RnY1UnJsNmhs?=
 =?utf-8?B?V3hyYjNla2g1T1d4aVJ4S255aSs3S0RJbXZMWkhiVnJTNExtYUs2MWU5bDcx?=
 =?utf-8?B?N0dyOFhMVUZZVEw1V1U0MEJqclQ5VDllTWhWRDU5Y0s4Q09iSnhLVDhPYWln?=
 =?utf-8?B?dlN0Y1Q2cjVBd1o3bGRWdVgrOWI0a0FLbzBLUWhvajAzVlpnbEV5elYvQndt?=
 =?utf-8?B?amw4NlFDQ1J3RVM4VHFGUlB3eW1KQlVOdlhHTlg1SHZ0WmxGM05vdTMrbGMz?=
 =?utf-8?B?WGEzTS9xckEzM3lydkZKcjZncTRWOUtJczhGaS9rTXlQK0wwRUllczJ1aXd2?=
 =?utf-8?B?WVdKdmNFRUhRblVsRUlPcmYyd3JiSlZCcDBRU0thbEFMN0VvbXBtQkVPSTRs?=
 =?utf-8?B?akQwekpqcHY1cFZVTlZhMXh6WFREbTc3VFRWbXpUbHByRU1vdE1hNTR3OXo4?=
 =?utf-8?B?UDBVSit0TVV1VHZ0UnY1VU8zaHAyU3lkU1p5UWQ1Q0k3aEF2OGlXZnJoTDMy?=
 =?utf-8?B?RENQRHBpNzdmMlMzYWVLNWJvbU5aZjNFZnJ4NzloMHk1MjRQQ3JQRlFCaWg2?=
 =?utf-8?B?R2l4aWQ2YURaekhQSTlncVBOWGVNNEZXU210UXhjUnN0eWxFTDk4U3Z6cFpR?=
 =?utf-8?B?T0RqaW14YjNsR2dVK1hrUXZyTENOdmN5cjdhTXlGL21zbzBBNlhFNXExQWhV?=
 =?utf-8?Q?bwiqn4jHsu/gyiaJyzLBATi9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3856bba5-2b72-43c3-308f-08dc733b8dd1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 10:58:00.2764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRIXrfVZvCg+VB2rox5yMdOS9cV3cYMeckbYW4x6A7LL+YpJ1TNkioPtVVrQtAxo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8427
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



On 5/10/2024 8:20 AM, Jesse Zhang wrote:
> Check for specific indexes that may be invalid values.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 051092f1b1b4..7c343dd12a7f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
>  
>  	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
>  					       SMU_MSG_GfxDeviceDriverReset);
> +	if (index < 0)
> +		ret = -EINVAL;
>  

This check is unnecessary. This is IP specific logic and the index is
expected to exist.

See this entry in smu_v13_0_6_message_map

MSG_MAP(GfxDeviceDriverReset,                PPSMC_MSG_GfxDriverReset,
               SMU_MSG_RAS_PRI),


Thanks,
Lijo

>  	mutex_lock(&smu->message_lock);
>  
