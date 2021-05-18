Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E2C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 08:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055FF61019
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 08:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055FF61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB0D6EAB3;
	Tue, 18 May 2021 08:04:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C036EAB3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 08:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeEK+nDNmSdbPLKWE4vVb3ifFefS59M4BgnAFEHcT2UuqfOKl+KHEsNAlIq7ERGsCAj0f70VWq3zHYH2qJYUVlyptWs4xbTdBH9btFOS/BPRF6CHfcX4UeOx9958GkowWdvJqQK0dwo0iuzBRAt3iTPzqtl3rvQnU4KTZ/QlvtdSHRIuk8Yd/Ys0Hbd46THGxmiWuvy25l3K3gzmsZT+kPevBMuVCeK8638DLas1dTJ6hxbxTH1cZd5NOeUNaeFV7n0AD9/gaq5t0nmTefbFyF2JLNlWa9SzKH7TBwK6VFk7AQJczfShD8vH5NjatEGGZF6TKT4bqfkrxtOOA1nYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWMf1TOVINWmZEK8xQCE4mwmz0MiOCdrcpc7h5nJn7Q=;
 b=RJlikJa+/UlcfJ9X7aA3Ak48mpRQ4bzylMsjFWchxnnHsOLngv79VrJNVeSE51VKLhoS1NyS6d5gFF1jP4aYFNWgvyvfV6/MAtEz37SLPMNhVFWNg+0CR1E/yCgQS2y7sK6CoGTa6vu7niWk5ev5h4ktiGzVTBcYLkqAueZCGlZXlGz/jugOWsOPSu1bZfTx8ATr0IXhkqK5ZPCmkw3dvqWLz0veRxnlFwk2HeRoKu54VmTw7soKQyFJDpYR1fv1pEC3vg8KjTTdk1/ckKGn1wBvAH4ykFEij4oouFoTr7mb3yTVTNM7ujezMDB1d2IftThW7lyxdLSEx0v7h2qB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWMf1TOVINWmZEK8xQCE4mwmz0MiOCdrcpc7h5nJn7Q=;
 b=c5kI6kGwPQiCF9D8z1cBlqn/7Qjm04PBVAS7RG0564UXO7/qzrMtTQIRL4nAJqoLU4foNrR8rh0lJfvjrUA4LD2zlWI5IE+m48yPCE0ZEmtmdW9iiZgLs5k1yQM9GTz235lOzIYFxVkHfyvsLL/9R6c5vBnBsayDr6NP4yTgfDM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1792.namprd12.prod.outlook.com (2603:10b6:300:114::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 08:04:18 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 08:04:17 +0000
Date: Tue, 18 May 2021 16:04:07 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: modify system reference clock source for navi+
Message-ID: <20210518080407.GA1853643@hr-amd>
References: <20210518062603.1357891-1-aaron.liu@amd.com>
Content-Disposition: inline
In-Reply-To: <20210518062603.1357891-1-aaron.liu@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (165.204.134.251) by
 HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 08:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5809227c-6243-4185-d7ee-08d919d388e7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1792863C48A864072D9BC499EC2C9@MWHPR12MB1792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oypo5hDcQ1jNDKfInzeFqKdJ/h2Ygh3JO7e8E0qGoJv1mPaIvy9IPCtuU9B8IBx6Q+XQZJ0eZ7M8pmgIL7Bxq8tKmcTDgdkdBTkHFoIbMBwdfXySbN2o9vsNleFHN5R5soTwTkYqz7Me+fSsRTUnbC4uCQhZGvPuK4SiihjsJHE0itmtI7VwscpzzTNPRdXIftvKXtjJyJqKkbszp/K/7fsKxYPXMzwUfJVUtQf76WnjadzxKFkq9dZBdife+eaY6SdwaQRUiBcK+uVAo9nAYizXl4Dbt2a/mWkOHmzfPGN3cUXfrrBP1T+XplSqaE+/CwUcmzlboqVyHK8wFrM5KYYPLqp3WV0mTaIRnWkb1dykJYkG5DIfO9oLXVGv+Ua8RjwLmmgaeO+gf8Qf16RIL3oDNL2UYlS2fO4C0NzqVrWNKVb/Mf44Wf5KCtxdJiW8z1ctZt1ZJCxWPyT0CiejmjwNCTDLdXR8HO4oyw0ogK8rEiH5/UOF5Wn3f/VUDJxMm1QQ6fqqbIWUOPuwbxARGgcVo11mAOwxOnuA8nxb9P8EQY4cFWlc5Uo5AVZbK+n6dLpU7mMm9nJkKnV1lv3Gh3mSDnfONifTuDZYc7PmWpAzUepsaQMjvU7oM8Xr6STwAQ7AKIRmhpEmmWgdalEsOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(86362001)(956004)(16526019)(8676002)(186003)(55016002)(316002)(8936002)(33656002)(9686003)(54906003)(2906002)(6636002)(83380400001)(478600001)(52116002)(33716001)(38100700002)(38350700002)(1076003)(6666004)(66946007)(66476007)(26005)(66556008)(6862004)(6496006)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AldrveVjmGqUoOKCxzhd6kem1aHUJ/Sn1EHLmsRLlyTUlEvYgCi4qNHe5Juh?=
 =?us-ascii?Q?NreXvJPiOaRToTscGQp9inpISdLTaXg5oXFoPidxnjhBDAf6acRUwiLvDU9N?=
 =?us-ascii?Q?SnE9D/AXQx0Z5F/yMFqXhJn1gi6MifwUH3ZVu5THBN+QyzpJQWStdLl/D/8i?=
 =?us-ascii?Q?06FZHeVXrYK4qT/1X4eM+VYicc7yRBbtLsRiIBNdi9babJZ0gSUcs41VT/eZ?=
 =?us-ascii?Q?+v4zo2f52kD4it5hNaiwhhTDdQyzU+4ceYnYhYJXRJFTBd/gywqFjhCySPIl?=
 =?us-ascii?Q?bmLH5wo57tHA3qvVLyHDXrze5A0Pdgt82M0CLX0YH7OBdtk/nTk6J3vnZ9Q6?=
 =?us-ascii?Q?gFJsCfKfKHH9kImCbyTFfmDzRpgb4U6jXOd0cnteexIVDfILANeScj6uvpvM?=
 =?us-ascii?Q?4p2U/zwpTgPGqOQctiPlSL/mxhGgFmyLrHBvq7o09ZIYI4sk+3zOJNsxN8yH?=
 =?us-ascii?Q?NTtRMrTebOAEBeeo0V5/y/0y0c7e/5hUru25XUy2EES2DznObY2WuxxwtH2p?=
 =?us-ascii?Q?R4ORW8ZkJNE4AzEjSaBKIbwfBA6x+7+MH7PV7isFrU2ChK1HV6RLPW1phsjh?=
 =?us-ascii?Q?4nBYx++9zm8ZoRA/QJKW3NRKx/bWV5Vne3AySAgVAm7v53CzMj0FWGDXaXWC?=
 =?us-ascii?Q?C/u54X7oPNfBKJx57t8gBa52QCSWNtx4NPEhtUx2PzS7V0UZcSHB4LnjiZTu?=
 =?us-ascii?Q?GA9hqiXPpwP3dIOeYRq+ctQNaq7dTH8UQjFkKLQt2pFPjZL2CGP5+RLREbTj?=
 =?us-ascii?Q?sH8mhmw3RXBihFrn8DZM2xCeCuAG7f7I1qlTUmDB6hKezo8f3JfYXO1XGtzS?=
 =?us-ascii?Q?xViVTBxVGm/QUGq1p43uxGPyB6F8AOs56KNHgDjIZ1BSmHiUcsCkz74UH6oH?=
 =?us-ascii?Q?g/4qrC3O/EwyXO+wtN5sTYCruQSqmVd8TZOVhyi08CXTXqvlVxCxaG41JuI2?=
 =?us-ascii?Q?szjjWuCN2CZ08Gl2UzMWpNtHoyezUh3GFuTMdo6Nyjd0KGiAsZnQ5wpXpExW?=
 =?us-ascii?Q?GfLRLDqg9IlKaLtyKOIv2BfE5cRWemSNTFqqrPfEJbbJz1RKmZVcHYQVXESf?=
 =?us-ascii?Q?txqmv0D9S1hM1XqLs5ke7M1HaWkPJyTbTfc/kuDEpF6IzhfKfoLaFdAXnton?=
 =?us-ascii?Q?9r+ZAOhRMSLGoB1g9y4UaO3s+02lefnnHYyqHlW73gbtYSWjwHy1vzJTIXWc?=
 =?us-ascii?Q?7yVKil/FmUVOpRYKDKAEl/AEyPib+w08fs05zVVaXemwjS7oCLnDRHFPQrMS?=
 =?us-ascii?Q?K8oPULRyM7QjiHUwXHhTLT4hS+F7oqGb89bi6VMcT32O/zcrz2Q+CRX4SUa/?=
 =?us-ascii?Q?+HKS8ihqbSwzqU2i7Ipo5NVE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5809227c-6243-4185-d7ee-08d919d388e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 08:04:17.7544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN3yh5Ld9iAmgQ8RBd0LCj3ubIlqS3gsdv6WZI0PbR5bl2GXx/IPXH9xOkF244WVG5xRYgaDpaZv9fizOdHr0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1792
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 18, 2021 at 02:26:03PM +0800, Liu, Aaron wrote:
> Starting from Navi+, the rlc reference clock is used for system clock
> from vbios gfx_info table. It is incorrect to use core_refclk_10khz of
> vbios smu_info table as system clock.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 8c417014ca89..83ca58426139 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
>  		ret = 0;
>  	}
>  
> +	/* if asic is Navi+, the rlc reference clock is used for system clock
> +	 * from vbios gfx_info table */
> +	if (adev->asic_type >= CHIP_NAVI10) {
> +		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +						   gfx_info);
> +		if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
> +					  &frev, &crev, &data_offset)) {
> +			struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
> +				(mode_info->atom_context->bios + data_offset);
> +			if ((frev >= 2) && (crev >= 2))
> +				spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
> +			ret = 0;
> +		}
> +	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
