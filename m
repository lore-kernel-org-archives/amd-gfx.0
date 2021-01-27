Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341FCC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14A92070C
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14A92070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7614E6E50B;
	Wed, 27 Jan 2021 04:49:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B19186E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD6/tw+Uhm/40p3FGaB7EbKtVK//d3ndlVKuUAC2gxLSoEGcHAsJxxu0fJkFX5d9PgAVjK7CLFcew2OVS3tEnCAanQkcTCYGm3K9epk6JoZTSCNUn4koQrzrybdHkVP2DbIfzE9OqKrQ+92+anz1VAnasksanvTsAq3gkXt2g0Su5+l0bb2XidYN443c6N4HrsECQanhBwUi+1maIC2o9B1GvE+F0IsezqTBdUK88KZ5Nra2kVJo5K1aaEGAUPZlgFwWWp4PawQa/2/eSC0sMFq18UFnBLaZUAeD34dFqUOWpvfI8jLTQmAhJ41UbJua5kvnHHEdo4zMyP/3bZBdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at2lxNanldrY6SouHo6oKGdfglfHQTEfqSFXnMDIjc8=;
 b=NTUOjSJQSu4f7SfSTYe4WdBz8qMMmFwl9jZgs54uQ/9a0SNVHSXCr9pGA3IoIAGEtzLqchkZO/dANCZGMt4dGn/0xBoIqMkv2bWCSwnvel4Lq2mIiqfuBqaKOgW8CMTEtQTfOJjmkQdBmgPzSCqAjI0UwB1Pkwow5u+iRDabTkjxhj7QM/riYEPLN0NsPvIMazXv05IyY6AXwcI/xUFvoTDZEOAQ0xYRnHgZ/AHVa/K5uEn0+uFX3U0mlXJw45AFd5KiSnpsdiUfQq3NtI+90krFeMmz2CCVdW136LDhij9BLHfOxxesHBEq2fuZtccvfPhsEcu72L8Sgmm25JUcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at2lxNanldrY6SouHo6oKGdfglfHQTEfqSFXnMDIjc8=;
 b=pfAucToRsV4LKuXeUoR3ZLm4IPSEM0pHoj0syOVXoUHR1Web/W2tjBP53uhZrk1B8n8kK7EYBzmpkXfOVzO+4w03WYzCRAMbVvM6bmTJ4rigPO8wYhYNYTqy0W0f9bymIvuGm9y5wfejBaC5rOSrHQlw2famZWAodISEkIuZ470=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.13; Wed, 27 Jan 2021 04:48:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::e008:e79e:33f0:bdf]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::e008:e79e:33f0:bdf%9]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:48:58 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Topic: [PATCH] drm/amd/pm: Enable gfx DCS feature
Thread-Index: AQHW9E2q/953EaQDD0egl8P7q3tgVao63W2AgAAI2tA=
Date: Wed, 27 Jan 2021 04:48:57 +0000
Message-ID: <DM6PR12MB407539857A58BB9C4F37D008FCBB9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210127014146.10902-1-kenneth.feng@amd.com>
 <DM6PR12MB4650AC724ECE20958063ACD1B0BB9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4650AC724ECE20958063ACD1B0BB9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:48:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ecda6635-be0c-4e9b-9eb5-2511c521a7ec;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ad42581-7e03-4400-9c4a-08d8c27edbae
x-ms-traffictypediagnostic: DM6PR12MB3178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB31786923E021815076D56DCDFCBB9@DM6PR12MB3178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrFS2WvWBs1JlJZpdYCzbZrN5aU0T0CItEs8H/JpCwzGe2yiAbWv8uY5pOnEl8cnVjk3SxHc8o0xwX8aOEvqK69HooUNOFg/q68NBP3oTPf73EZIliO8a28GadMYvIqnVNvTuRbuDIEMIVZuNWkAbPDSYxpTTPOwYpCi1arsWwrLrIXikXtx+X4fWjzoO37pN2WdsA1gy738UNCxhEN2CdorSVc91gMKjdRx/OPX/EYQI9tHhjfi1iIfbyXTW5sbmEEniiQ16J2wCUZlh/yQ4S/x+vp6rM4DukmPnWAFy4MkCnF0/5eGk8Oce0FjQPbUmsSr0wILFfoRQ2RltaltM8oCFiZYJqK7C2o5DVbcOtYMVKmH/kQjf+1Gv/ayUD1UMU2U/NZ8U6lbP0LK+x8getre9iEOxu0O4YB3aaUOJajFcrxsXfbXh4lzDqgtvcHW72aksCULu0pssVAE+3BH3c7pOhb9nNX7xV5/nY7CEMdbcJoF729HpdENLBO4EwHy7nrsk5C4hE/RnUR8Wyq0pcEgIBXoxWDnr4yda6SR2/DnxlG8VOACjzVSfVs11xBW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(52536014)(186003)(83380400001)(66946007)(55016002)(110136005)(6506007)(66556008)(76116006)(9686003)(8676002)(4326008)(966005)(66446008)(8936002)(64756008)(26005)(66476007)(53546011)(5660300002)(316002)(478600001)(86362001)(33656002)(2906002)(7696005)(45080400002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f1P8jbvLMN6KaIC9pTLIklE4zuo9AoqzW0fQRJGLu7AnOUiwYAwEtqNkBp+n?=
 =?us-ascii?Q?6QAU8nebZ9aBSUMstbJociCypdxdpG4MpRSrc4HiLsnob8yvlZlkfKE/3lp6?=
 =?us-ascii?Q?cmnVOJof7Owr5nLQtDPrnXzizmnk0bkwyjCj9cnPjjajN2W83YflNXLsIY0y?=
 =?us-ascii?Q?lQnH+9HZ5pLTZI4qdoTJlDmVrCQe20x/n7bjmcO4gRrVrjxJs98q8ycUuq0B?=
 =?us-ascii?Q?pc3fIkzdRImcEw1PiPySanvjYk/x8F0E6GZF2jDfRMihQa4lXH8o4N7DugYk?=
 =?us-ascii?Q?WBHdwL8FLIfdRcHmYm+j6vYGtixVic6az3BjHkKof3XHHSnEVA+pOUn2LrD+?=
 =?us-ascii?Q?wkggJL0ufVIuyG0ArOzVhup3C53VvI81cHgcHC+4CLYqUaBGP0BEWDpz0gZN?=
 =?us-ascii?Q?HkpJzcDbfjK3mSEBPjqhVm6ev2Zqqi3k2bFSmV9l7fNdFtKdNYKWFKZi2loJ?=
 =?us-ascii?Q?2UVpYWF0HH/ZQ4JlNowriIxQ1nuOrbkq8rkgBCOiCVtHM3wCzy/uCiaeUhHE?=
 =?us-ascii?Q?STgO+PuRJ0LhqdJWc6FApwQo0PcU5AU/fvNYc1hvp3md9uHbol0QMMbUlylO?=
 =?us-ascii?Q?Lv9cHF8YEX7sbAvzqXayGK21kMDyOiLdzIS+GRM44jIz7uro90zKR6Y3wpel?=
 =?us-ascii?Q?gKQ9ks6dEuHAPEpb0teBSMXGh9pP3JZLu+z8E4B9AMiEzagBxqUo9umsq8+m?=
 =?us-ascii?Q?9tm7GzZmMJdqOTAZoIG3p4nUeoH55EQlFfLMmD7WBNs+C6jMr/VRy6FIRlDL?=
 =?us-ascii?Q?CLK9c7i/r/eWAeuxUK23fpVvJ9ccJPopX+axmzfw5OgCD6iPgdhxSRrDutEP?=
 =?us-ascii?Q?MF+euPP5shk5FUv4yvV+Tzk02uQ6waNhVrchzvYRQ78NMHTpgeKKIPrS9bnW?=
 =?us-ascii?Q?yCPyLJmdfTE0bLKfXI0m4qAHGCg9ouYNn7bKlYts5oTb5KUeawqEiAUfPQgT?=
 =?us-ascii?Q?zJvfxDi4RACS9iUVT2vVAro3Ok3xB3k0MbdsmJz7x80pzuVqD/LkVWPnSW3b?=
 =?us-ascii?Q?kjxEnFhEhoxyFJxNl4/M1yAze30G6hvVxdbfuCcu9r5Ai45RYjsNzCDk0OO8?=
 =?us-ascii?Q?07ciOBQO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad42581-7e03-4400-9c4a-08d8c27edbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:48:57.9031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJRS3GY6qi8cVuuMxxBttZXL/eARY5FyhKllvDoulGQQhe4JxLUimEcI5XaHz7KRCa13T8I1uJ+h3JdkjOzRyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

+	if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type == CHIP_DIMGREY_CAVEFISH)

We shall consider merge the logic to adev->asic_type > CHIP_ SIENNA_CICHLID. I think it is also supported in SIENNA_CICHLID, right? So we haven't verified on SIENNA_CICHLID yet?

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhou1, Tao
Sent: Wednesday, January 27, 2021 12:15
To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Enable gfx DCS feature

[AMD Public Use]



> -----Original Message-----
> From: Kenneth Feng <kenneth.feng@amd.com>
> Sent: Wednesday, January 27, 2021 9:42 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth 
> <Kenneth.Feng@amd.com>
> Subject: [PATCH] drm/amd/pm: Enable gfx DCS feature
> 
> Background:
> Gfx Duty Cycle Scaling(DCS) is applied on the small power limit skus.
> When the current/power/temperature exceeds the limit with the heavy 
> workload, the gfx core can be shut off and powered on back and forth.
> The ON time and OFF time is determined by the firmware according to 
> the accumulated power credits.
> This feature is different from gfxoff.Gfxoff is applied in the idle 
> case and DCS is applied in the case with heavey workload.There are two types of DCS:
> Async DCS and Frame-aligned DCS.Frame-aligned DCS is applied on 3D 
> fullscreen and VR workload.
> Since we only supports Async DCS now,disalbe DCS when the 3D 
> fullscreen or the VR workload type is chosen.
> 
> Verification:
> The power is lowerer or the perf/watt is increased in the throttling case.
> To be simplified, the entry/exit counter can be observed from the firmware.
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 
> ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 24f3c96a5e5e..436d94cbb166 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -261,6 +261,9 @@ sienna_cichlid_get_allowed_feature_mask(struct
> smu_context *smu,
>  		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_GFX_GPO_BIT);
>  	}
> 
> +	if (adev->asic_type == CHIP_NAVY_FLOUNDER || adev->asic_type ==
> CHIP_DIMGREY_CAVEFISH)

[Tao]: So DCS is unsupported on SIENNA_CICHLID currently?

> +		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_GFX_DCS_BIT);
> +
>  	if (adev->pm.pp_feature & PP_MCLK_DPM_MASK)
>  		*(uint64_t *)feature_mask |=
> FEATURE_MASK(FEATURE_DPM_UCLK_BIT)
>  					|
> FEATURE_MASK(FEATURE_MEM_VDDCI_SCALING_BIT)
> @@ -1437,6 +1440,15 @@ static int
> sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
>  	smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_SetWorkloadMask,
>  				    1 << workload_type, NULL);
> 
> +	/* have to disable dcs if it's the 3D fullscreen or VR workload type */
> +	if (smu->adev->asic_type == CHIP_NAVY_FLOUNDER ||
> +		smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) {

[Tao]: Tab should be replaced with space here.

> +		ret = smu_cmn_feature_set_enabled(smu,
> SMU_FEATURE_GFX_DCS_BIT, (workload_type ==
> +			WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT ||
> workload_type == WORKLOAD_PPLIB_VR_BIT) ? 0 : 1);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return ret;
>  }
> 
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7Cebc62214ec3d4a52ea6e08d8c27a2956%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473177242163482%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=imvlk8AvH7ttaSnLksU0exYYWxyOGh5sXwl%2FcLm7Afg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
