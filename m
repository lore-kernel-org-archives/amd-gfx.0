Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4050D15D98
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 14:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D53110E0C4;
	Mon, 21 Oct 2024 14:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rnPypJEc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F0910E0C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 14:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZJnV9pmjPilkiIbRhb5ToGv0OCgSoH7eNoTF/GFoGsC27+9ID/PvHIcans4vbZ5Ga0q0Xyw5Udgvg1gez1PIo6QpC3ivmD/AY0J5+Sw7AauJlsd08Cbb8x+j+rfUovmU7SUEu8N+frt/aqF8rYw7LAl3QUbXwMuzl8CCQyfnP+h2Vb+lT788dmT8zefHaO6/CGiVRKF7Ea3I1GX9hPNHnV9ByyVzJnqcGx9mcMt/fM4EMTRXvD2mESc3+4BqtqwJ1ojntWbW7aYJL+V7tkOfeUIbbcUBWDfA170Cw188vW2itiaXOTVJwtsOvv+tfR2t8gMZcXPOpudgHKtrbuYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgnhwO+FBjOkMIvTgyhevmuacUTXOWEGATjCpDySXWA=;
 b=LV2IClqeSGpksZu7VZQY6EM1uCnpqqTNQgBhcKNxKqDchCdOi9S9ivpaGBK0NHuke0m1m/X6sq93pTnTVUdE6XmBicu0qz7XwFm0ST6zyF3yI9vdzJtZjQTipEdivBUlxGnJpf1R9WeV9bholofyThOTUUSvhqM1fx9PiGEZYCDFbFf9kX0zXLg2SakIvREYL96K6ObFO2jRpTjCUsEcem/iykMiJf2O0FKdtZb1Rx/mb24FmHiqyCNXNtJ3UP2lxLGxU/VRhUwz3/HbEHQuaDjZ5k/Ad6e2N/EsorK7mp9SThaU+O0Hnd5xzTDzV7coCGMDZnSylM6nmX2bcZFRvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgnhwO+FBjOkMIvTgyhevmuacUTXOWEGATjCpDySXWA=;
 b=rnPypJEcH0IKZ/P4bvIrVrFSWHTrLk47HSZpnve9GEcqcSDHj7SCJmCSJyX4wX0oAkxIi+QtsVAIHrE4z/g5EcoDYG0xL3rubGpg4q9zRwQu13qZ0eGuVfHIBvTUI301EUTV5rr3KU0XOpBi+XbAcCeDYFqIn13ESxN3+oZ/CZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:02:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 14:02:31 +0000
Message-ID: <a0228259-05eb-41b8-96c7-5b604fff0a1d@amd.com>
Date: Mon, 21 Oct 2024 19:32:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <20241018202128.97719-1-kent.russell@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241018202128.97719-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 148cc65a-ff59-4a13-a84e-08dcf1d90148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmthQzA3bElzUGRvMDhSU3kwZkV5M0J4Y0hwcFk1SHY1VHNWaEtmaWNJandu?=
 =?utf-8?B?a1YxbHJTNzM1R2tTZHZLRElWeUlMTStqSUNPeDBLVFJGbUZkazIxWXBuaU5T?=
 =?utf-8?B?UlZoV3FnRUYzdVovalNSemltSmtWRW9JUGdjQm03djhYbjgyM1IwWGlOQlF2?=
 =?utf-8?B?T0dTbGlPbWgvRWhKcC9BMHlYVmRhTTI0MVB3cGwrdXRGalFDLzZYbmViZEl3?=
 =?utf-8?B?Yk82VXhhaFJEcHBRajg0aGNJakd0VlhrQW1YTm5pdkpmMllPKzJIWmRXUzVq?=
 =?utf-8?B?cFFmaVNXZ0YxdHA4Q1FWb0h3OGlIc3dkazBYamYza0Z5b0FLOFpSeGJZc3lQ?=
 =?utf-8?B?RUg2SWxyTHFJcWZESDRpb2VqbUlJNmdqelBzSGJHVDh4d0t1MUN1Zk9BRGtJ?=
 =?utf-8?B?aDBUcDFDTFM1Q3VKSXFnK2JlRzYzRFJaL0srdHZOeFRrQTRRN0ZpdmgxU1Ni?=
 =?utf-8?B?VCtML055Zk9mWWJKNUwxUVo2NjhXZmRXd3BWZTlrcXQ2S2hpTU9DWEhScFVw?=
 =?utf-8?B?T0F4Q2VYWHBrOHdaUU9HMzdlUzZJYTNnWDRsazBNM1RxcjAwM2NaYjh3c2FT?=
 =?utf-8?B?Z3lyelNwUWtZRjhUMGdqdC92cVdUT2JEcmdtKzRxYjIzTnlITytDZVMxOTRx?=
 =?utf-8?B?L0VnalpoY2tySXNGVGc2K3ZPU0VDQjBYMWRGTlRZck8wWTBvazMrNEQvYloz?=
 =?utf-8?B?VEVqQmlpakhqV0NVZXAvbmZEejVPVzdZZVdreFFWcHd6S3lyVUNDdzM1Vkdj?=
 =?utf-8?B?bDB1b1BtdjNqcUJEMHdwREUyWC9nRmhaZW01UkZIMkZKYXhkRWdBc0F6OVlG?=
 =?utf-8?B?TllFVkNQR1BZQ2x0TWZMRTI2UlRvanUrZ21VMDg1R00xM3ZaVnExZmh5SXpT?=
 =?utf-8?B?cXhwTjdEclpsU0NOa2FnK01HM0xFYTRwb1RpejhmTFp5aHczQnB4SzlOa252?=
 =?utf-8?B?OGxlR3QvSFhJM3NVMXZCcW5KMzhpUGRrUWJ0cUpJL2VSSS9vc29RM09PaDZX?=
 =?utf-8?B?aXV3S0IzeHVLMnl3U0kvOXcrb3Y4L0thT3plUHdsb2huM3EvT1RUNGxzQlY2?=
 =?utf-8?B?VllaUXJldWhjOFA4M3pVMU5pM2xsVXF4ZGlDQ0dpVDZXTXRMM2thSkJnTnI2?=
 =?utf-8?B?Vm91R2Y2TTN5OWx0RUJ6VjRHWlpaWXladlAwY2xoMlZrM1JBMEUwWllHWDJV?=
 =?utf-8?B?dUhYNjVnNXh6TVZZZXlzcFc0NHZacmFJTG5FNFpHSG5mRmFOWlNsdkZBRTJ5?=
 =?utf-8?B?UWdoZitmc3JNa3BMSGhrQUV5YzJzQXZmQU1WZ0tKQlFTNVZZRWtSMjN5RGRm?=
 =?utf-8?B?VjZMTXlRdnpINUpISjkyeWRVcytjY0FEcUcrTmk0WUF1T042cjdUaEl4MmJi?=
 =?utf-8?B?UnEycmVUVndNUyt0anhwSkJOeXNRSVZxNUR1SUpzOEFFa3dGd1BSVklmZCt2?=
 =?utf-8?B?ajRBWEZpTGE0enVSUFFxS1lNV2lhcFMzTU5Ldm84VGdaNTZzSUx4RG5vSFpk?=
 =?utf-8?B?cEVMelNGd1RSUk4xc2VJU2RwdjdpUnJTdnNya3ZmenFnR3p1QjBaU3NHMmNh?=
 =?utf-8?B?SUVWWHJacGJaalNrLzhQcUVIdEZ1cHFkSXNtWkNLOE4rWjVOckNPYWs4N1Vw?=
 =?utf-8?B?Y0ZscXAxSGNsekM1WWhCUnFBQzhSbU9sY2cyWWxncTRqaHgrOG0zTWRnV0xh?=
 =?utf-8?B?YnU2V3I5VjJHMmpSQzJqaDI2b3R0Ui9PS1dtNVhuY1kwR0tKMXFxeFpYVHVu?=
 =?utf-8?Q?rWk3xFUPPjBdkRnI14pZqGGDI7AkAxvUpYof5If?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnoyNE9CdzVBSVRhMmFGTzY2ZzJSbUUvdm1xbGpuRjFOTUt1ZWpTcUg2Rlo2?=
 =?utf-8?B?TFhMRXQwbU5mUmxRRTk4U0IzR3dGWUlSUFBEZmJBakprZWIwRmpQc3AwbXk3?=
 =?utf-8?B?bS9QcXF1eXZRZnVPek9wK2t4WTZZbExIN3dCNzh6ZzMyV2JnK2JidVBKbFRG?=
 =?utf-8?B?U3NWWlY3Rm1hNTRCSjN1OFNsY0JDbm82RjZPeDJJckVZV25uNU5nMkxoVzVq?=
 =?utf-8?B?bGpSY1ZKcjUzYXNBM0pTNEU0NjdoeE1McGd0OTBzaC9MQjBPU0lBM1ErSGcy?=
 =?utf-8?B?UVFKVXVnUXd2cFhGeWRkOGpPZDUwalFNQUU0NStJTFJyYWNMWlR2N1FZODNi?=
 =?utf-8?B?N2pjWnJUNFR4a0lDSStpS3hlSFlTWFhtRkprMmlyVW5JZTUyaTVGWER3MVJr?=
 =?utf-8?B?WjUzQk1HWnh6NEJlNm5CUWlWa3ZEbVVVR2JuUDNHemFMM3pSUVI4STNUd3VR?=
 =?utf-8?B?QUNDNVdlQlI2VjVJRms5R3VpNUxuR25ZbXZKd0RIUHU3S0JGOC9Rc0ZEWGwz?=
 =?utf-8?B?WmhFMlRoVTdsajF1ZlFlekhqWjBhNkdXNWgyNVNiQmpjbXZ2MUUyN1dKNHlQ?=
 =?utf-8?B?Y2ZrejVSOE1ZYmU3bDFvUFE1SlNOb084bVB2elliY1RwazVEN1kzR2ljeGtI?=
 =?utf-8?B?N2dkckdaTTJMZ01tQVo4Q284RHlBVTZ0SXBwYVBHdkVGeTJseVY5WFZyNEY2?=
 =?utf-8?B?TSt2YTNURSs5cmZLaDBvU3ZjaTJpSGVKU2E2MnpjV3N0MjBvZVhPYVJsbUtG?=
 =?utf-8?B?d3ZDR01DZytJNjRwaVNCV29EdkFIU1FzTWM5U1VJbXo4VUVnclpnOEM5WmFw?=
 =?utf-8?B?ajllK3JRTEtLZzdvV0hPQWQ0MVlDTnJJWjAvcUt3K2NndCtvU09EZWlUeDJR?=
 =?utf-8?B?Q25OaDQ5K0RRcVBhdnZTQWJUcGp2RC80dDVZbUFWbFRORHBrcDluT2tDQXlJ?=
 =?utf-8?B?YnJ2RHpzd1RMOW1FbThoNklzOWhVUG1lOVZFekZKZTBpa1Y5bUQvTW1MM1BD?=
 =?utf-8?B?U1lCYWdIZXI3Q0J4TFVPZXFXajZhZUg0dFkvaGFJN2VTcHlNbUt0UWp3bUhy?=
 =?utf-8?B?K3c3d2RqREtVenA0RUdweHNNWG5oVytXcW5nb1NsUmM3Y1JLQVNYUXNod2NC?=
 =?utf-8?B?ajNVanBBSUdvUVZlNkZ4UFdjK1pSUDFEQ2pQakFrUjJmWUFOb0dWemR2VmU1?=
 =?utf-8?B?L2p0ajZsUzA5cWZPck53eC85QXB5Tk90ZFJQRENGcXB1dkdPeFpmdVZ6d0h1?=
 =?utf-8?B?YzNMRXJPOGVoRzlOZW9FaEFpVVNwUkMyWXY4QTVQeThodnN2RFBVYkM4Mm81?=
 =?utf-8?B?M1hXT2VrdlFqaG00dE84ZCtVYzcyc1lTNmJ4WjJWUzJpZXBIcnc3WGRzRU9z?=
 =?utf-8?B?cFQ1cGJiUWZHWHFndnd4Z3BLWEFmQU02VU9Jb08wQjhTeUpuR1hEdTdQM3lz?=
 =?utf-8?B?QVp2OFlwNmFEV21NU0pwU085WVZ6YzZoOTZmNWFxWXYvTnlFMFh0VFkrcENI?=
 =?utf-8?B?QmN4aHlvQTVDNlNoc0NqdW5OVzBaMVdCMVNRUlh3bVNqYm8wMXRoT0ptUVBM?=
 =?utf-8?B?V0lLY2NEWTB2TS9NcCtSZERlK0J1TXZaenZoWjdPQUYvYlhjeUVvT3FGdHB2?=
 =?utf-8?B?TEI1UEltMFpjNzZNUlF2TnBTRDQ3QVBVYWdJNTE5VXdRczc4djh3N1hjS1My?=
 =?utf-8?B?d25XTlJ5SmxETFpnemdzTFpPSlFBaVJkQkFMWWdZbytENFpJZWxWMHRiOEk0?=
 =?utf-8?B?YTZGMjZqSWt2alNFSDJUUVlMUDhDbnl5b01RazdHMkNnTS9WajFnNGJYVFdk?=
 =?utf-8?B?VllFWDJRN0s3QTRBWGErWmZsTGovdTBvYit5VUJVaTFyajkzRWJhSGFqOEF2?=
 =?utf-8?B?OWpiWStydVJVcTZPbGZWZGY5MGF5ZFMvR0FyVFJEZjRVNXhSaU1qcG5DdlJh?=
 =?utf-8?B?eG5XUDhYQjhJdTI3blhFOUV6UWVKZmd4RDZTMjNlTTc1NlVhSGtRdU5Md3cr?=
 =?utf-8?B?S0wweE80SU9RRGhvSS9WSjhtcGJVUWFnaTNFOENjUWRoOXE1LytXMytSa1FW?=
 =?utf-8?B?M2RtZEZQWEJQeGNEWlVsYWtxd2RzY0IwdTR3aUJod0JiR1NMeXFDcVN1eWZ6?=
 =?utf-8?Q?mNd1d/hAKmb0YgAzFlROBCrsB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148cc65a-ff59-4a13-a84e-08dcf1d90148
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:02:31.5566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F0OBMYFO94bW+L4O8NnRfdQZfj8qyIho9vs9nZUHCG9BOCvpmL8U7L8ctyYRgfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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



On 10/19/2024 1:51 AM, Kent Russell wrote:
> If a 2nd fault comes in before the 1st is handled, the 1st fault will
> clear out the FAULT STATUS registers before the 2nd fault is handled.
> Thus we get a lot of zeroes. If status=0, just skip the L2 fault status
> information, to avoid confusion of why some VM fault status prints in
> dmesg are all zeroes.
> 

I guess this problem can be avoided if the information is read from IH
cookie/context rather than from status register.

Thanks,
Lijo

> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 ++++++
>  4 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 5cf2002fcba8..5fe7a1c74ff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -175,7 +175,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>  			addr, entry->client_id,
>  			soc15_ih_clientid_name[entry->client_id]);
>  
> -	if (!amdgpu_sriov_vf(adev))
> +	/* Only print L2 fault status if the status register could be read and
> +	 * contains useful information
> +	 */
> +	if (status != 0)
>  		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>  								   status);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 4df4d73038f8..25a3dee27d81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -144,7 +144,10 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>  		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>  				addr, entry->client_id);
>  
> -		if (!amdgpu_sriov_vf(adev))
> +		/* Only print L2 fault status if the status register could be read and
> +		 * contains useful information
> +		 */
> +		if (status != 0)
>  			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e33f9e9058cc..3dee7474c06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -137,7 +137,10 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>  		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>  				addr, entry->client_id);
>  
> -		if (!amdgpu_sriov_vf(adev))
> +		/* Only print L2 fault status if the status register could be read and
> +		 * contains useful information
> +		 */
> +		if (status != 0)
>  			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 010db0e58650..f43ded8a0aab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -672,6 +672,12 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>  	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
>  		return 0;
>  
> +	/* Only print L2 fault status if the status register could be read and
> +	 * contains useful information
> +	 */
> +	if (!status)
> +		return 0;
> +
>  	if (!amdgpu_sriov_vf(adev))
>  		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>  
