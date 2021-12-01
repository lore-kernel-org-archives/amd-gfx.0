Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14407C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 02:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA596E3EF;
	Wed,  1 Dec 2021 02:28:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214EA6E3EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 02:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEI69MkELlLonb01iTl37a6WTJPBAWMm0p3F2mL+AuvvDbh6Np5kfKBTcBpX06sqZyJgobCqDvdZ3KdpUb960A8OU2IMM4r0N0xeyO/78w78cAy3gqsDwxV2j4d3YfthqyXCwVMW7G0YatAtJrV8XY898YOKv8mLg64iZdlf96zgWhmSTRWUnbRXeNmzUoJULP/FIioB2wYRxosvmR9SSI2eOgx3DXs48ELJ2M0afH/uwlSzmsVGWmoWrxVpqfEt1WL7SH5fCFv28FxEuRKkfMQOz3ROIL86v3sV2I4K210ODs7RDgdvjYg9gTwAmV1ydqiqpaTgcQPssqG0aBOpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rdrYbVMGXtw5K5IuF35Uj1y0RSSQ4b/kbQb0/27l/4=;
 b=icVVZZVOvjOGRIEowZz7CAotYSk2kV4JMsCQTsevdf/UL7EV+5r/NXSATe59i6X89mfXIydK4hf37amDNieH179kxofJo/PAoBbin02WG9r3SNADCJRgmemoJM8MCCpUlvhO2lXNdOVju4+SwD6OT0yNzK0EGyf0tL0h/G/9PjXUyJrEekr55SIXOk10Q/Pth0L4sGm8H7t7iqvjWzwosP/k+eLP2D7sSUrofkgF7WoG58cTP/GffvWpfzeYDZGPA10nUtgUvKvJPv89Jjty5vN5RFggG7mCZDAB4ATwuqUix7U/k/RI+P+2wVhMjP64qa8z+LkJMc7Fl98E4HLxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rdrYbVMGXtw5K5IuF35Uj1y0RSSQ4b/kbQb0/27l/4=;
 b=JCV1K2cGNndDO5uKy7l/rvUrX1Nwg5yG/GLN51SozdEbutox85JXceAdpagknxX/ddpLfVBaqrZiNasJGTD/kRfVlOOV52Z/11tqYIzS/BjHknC3PyGiCraUOII6l2+FGDRWUxMla9mMIoqik+pd05/LwhD0nsIauzORsTiHtv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Wed, 1 Dec 2021 02:28:17 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::711a:4c44:b4a7:4afa%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 02:28:17 +0000
Date: Wed, 1 Dec 2021 10:28:08 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: Christian KKKnig <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
Message-ID: <YabduKz2tJssIi4Z@lang-desktop>
References: <20211130051721.3192979-1-lang.yu@amd.com>
 <b4cc4c24-e273-6e82-4baa-48505b38e27a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4cc4c24-e273-6e82-4baa-48505b38e27a@amd.com>
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
Received: from lang-desktop (165.204.134.244) by
 SG2PR03CA0098.apcprd03.prod.outlook.com (2603:1096:4:7c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.7 via Frontend Transport; Wed, 1 Dec 2021 02:28:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 475d762e-b7ea-4180-1571-08d9b4723bbf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14344789B6F4E64C63438791FB689@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4JoxGFqs+3Q/0wB16h3ZkNnRVLXBlI1Qixm4XZptu6F00CLjfWATcuimPjcQwdJ4+0ONW8zfer036Be3bI197ms7JfzERzeDszEQsGhITX9VBrzveKUI1TCuf+LWJ+7wKLu1JZvUKBoAvQ8h98et4Wj+zHkNTpsOXDZEHe1/o6fuh9Gyl2sSIFaM9ju081yFkjhdv7SlcRPknwYSI0PR45vB/saeVPDuLgzYU5ecWli7vgcu4NCZthJWB4pQwjTVdBgz6pKesRpRaIagt6C/bj10dOXxx4/dvAUO91O1hOmRxpJ310rFW5jeELAIMxnAfk38di2CZcz6Ni+nZiRBhr9VpxlH9kYMFSrKS5907K738i8Z6V71nkeICQAQD65VfpJ1wZzmIguX8RJuHactisszORDJGIINI6Yj4vQmqLHl+BZCwuANHDUkrrAYkARfTEwaCtktxTCfh6URGYMSFslYo7XXDh8BeCiJH2hGoqAxKqfw8djmUBvfuRYdCVG5I07b6/iNhWWkZe6XQkHQeU4ZC3lZ73lEG2cYeMDuLVq6mgRpoDm/8en/l3LqxZZ7Ko8oPHI7nRlnm1fzn6jj+H/ZhVNnOfbIUuyHb5ChgvH4/Cg6QAWZQRp9NZuJ7LpzUtbfTAYNj3l07x69+Okow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6496006)(186003)(2906002)(9686003)(4326008)(54906003)(8676002)(5660300002)(508600001)(83380400001)(6862004)(66946007)(66476007)(66556008)(33716001)(8936002)(86362001)(38100700002)(6666004)(956004)(316002)(6636002)(26005)(55016003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KjOZrpOkF3e2kCDfKMZoeNzkx6DypZBs3Go22hTvs9/PdiIRrD6jrx44lNtX?=
 =?us-ascii?Q?5Soby6TOS27jJUV/w6Z66h4tlJQlC7Qhb2Ul+Ixzt3vjSbO0wBTsufsyUSTo?=
 =?us-ascii?Q?pY/TnwkXv6ckXQL5XSWXakH2NyKkD3sSRssbcwhRzHXaYEMZ3duW6pt6cRaN?=
 =?us-ascii?Q?swJDXOs9z8Fv/MAqsorzJFvG0sGmWQBoUf0adFFdH9vD6OTxNX58RgOdG5Kv?=
 =?us-ascii?Q?9TlyvetDTJ1cMTlUarcPHmJQNt4YEy6NF2hRbwCbhenUTWthL2Sjw4l8pLOC?=
 =?us-ascii?Q?ATg18dKGXzoQZf+NADHwSCv0WZqbeuqZR47M1+L4Ni11K2QO5o1aXTX0P+N+?=
 =?us-ascii?Q?LQsPgVXIBGXdVezo6HqEvU0grCcgtTm7yNA1YBG11i4PuQR8PEq0xn7SLi9K?=
 =?us-ascii?Q?2WyZfdrfXl8xy5BZR6vIozjPhzSIGMU7K/u3HRIfyz1yMNI4DZETqnUbu2fR?=
 =?us-ascii?Q?t4sLXJ3PfjPhHbXWFjkCA5Edikl3hF+sBCCdFE6yCPPge6YV1lQNku6o7ACV?=
 =?us-ascii?Q?EKyjfxnq4bTSwqMzbGkYt8++zG/drAqr2Hv+9jHXrwviyLn0tTimtG9FVJn3?=
 =?us-ascii?Q?jLq3puZdsFQDeds3qqxcNEtPp38K1lMtUZOwZNeGK+i2ldqVA4ajni05SXP4?=
 =?us-ascii?Q?Wr3e25HniwE1kwgOfrKFTmrmxjI9twXScJnAkz9fiAnF7yHLQp8lCNQ8u+6T?=
 =?us-ascii?Q?62uUrwJ4cTKj+UMkQFTdmUBov4ZMJ35gpFp298Ob6GtI8dj2d1wwTlvNZ98O?=
 =?us-ascii?Q?b1ZKa9xzyPSyeUOD5vx+jImwANtbX++bVPMeYjRFoU7F4ppj2jYN9G/0zXJO?=
 =?us-ascii?Q?lOPTqjIWOiHEjik4c/dm8gFHymfqWs4tfuA5CTr/fm+Yl/Sitb/8zlmX7tHC?=
 =?us-ascii?Q?u96FONuVJiX9jNssM5XQSBgBUYpGMJtcM/G71DlowP0AugS/X6slkmaoA1cl?=
 =?us-ascii?Q?CyQ1OMgFRXQt5nOtsb1/ZNX//4qY4Gty6HffyPHyAJy1pHU4sGov5wPWkz2F?=
 =?us-ascii?Q?lwFNL1E/FHx248hJ7QGFmC9t4c5YciI9dLYNn7tMMsa8ShGJMqD4MkmTbu2X?=
 =?us-ascii?Q?0qEghSkCWqCyJ1iQ6HhGwwRFXAiu5sBQwXOh2rpF2JKqbRNLvM4rDPiNqd12?=
 =?us-ascii?Q?jB9AQRv/U0+jZeu/VYm2GBz5olLDdkDKkpSZ46whdm31Ky5XhpH/pXFzekSp?=
 =?us-ascii?Q?Iu20N/W1IffxDnOtSv0H/oSGSDwd/WJBt8ynXY/GExNHbkiIRj2EpHzaTeL4?=
 =?us-ascii?Q?YS2O/UHge92cARAGINv1nsMKBHnsj0EXGiGT0//+GdAV4lKAjfySr91cJhyL?=
 =?us-ascii?Q?urK0IrY2Eju3+FA+9X0EHcyCLITuDi2xjA78FtWof+Xk/gddJBMeCDoJfPZd?=
 =?us-ascii?Q?lVn+REQ+3PAOpVmgXEmpB/7vQ54mtz1E5/S9TuE1B17n56I3uWQnltWKdeN2?=
 =?us-ascii?Q?5YpmObMN09KUpVR/KYDB15rfR2u0TzjbuVMDX8jHKMZfcrx7x4oyO6jDJq26?=
 =?us-ascii?Q?/v9EnGdkeVEyO8t04z+GAtDeNxueV+1DWEFDaS3mQiaAnKUIJLCTaHqRqLvq?=
 =?us-ascii?Q?q0jKrXV2yAVWsBzfTQ4ArVmO+L4XzLP5cC/Bw4gMfixm5Xr8z0olEOPmP7nt?=
 =?us-ascii?Q?WNo5mY69xc3sutx3UGHN5sg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475d762e-b7ea-4180-1571-08d9b4723bbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 02:28:17.6423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLH+GuhtqsJph+Ld3Zj6fgsi/3sT+MzCQ74+J8271P/eAF/SsmXO7b9ksK7kLYULpsWoJdrpZb0JUiCmR9sxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/30/ , Christian KKKnig wrote:
> Am 30.11.21 um 06:17 schrieb Lang Yu:
> > To maintain system error state when SMU errors occurred,
> > which will aid in debugging SMU firmware issues,
> > add SMU debug option support.
> > 
> > It can be enabled or disabled via amdgpu_smu_debug
> > debugfs file. When enabled, it makes SMU errors fatal.
> > It is disabled by default.
> > 
> > == Command Guide ==
> > 
> > 1, enable SMU debug option
> > 
> >   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > 
> > 2, disable SMU debug option
> > 
> >   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> > 
> > v2:
> >   - Resend command when timeout.(Lijo)
> >   - Use debugfs file instead of module parameter.
> > 
> > Signed-off-by: Lang Yu <lang.yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32 +++++++++++++++++
> >   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39 +++++++++++++++++++--
> >   2 files changed, 69 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > index 164d6a9e9fbb..f9412de86599 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -39,6 +39,8 @@
> >   #if defined(CONFIG_DEBUG_FS)
> > +extern int amdgpu_smu_debug;
> > +
> >   /**
> >    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> >    *
> > @@ -1152,6 +1154,8 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
> >   	return result;
> >   }
> > +
> > +
> 
> Unrelated change.
Will remove it.

> >   static const struct file_operations amdgpu_debugfs_regs2_fops = {
> >   	.owner = THIS_MODULE,
> >   	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
> > @@ -1609,6 +1613,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
> >   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
> >   			amdgpu_debugfs_sclk_set, "%llu\n");
> > +static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val)
> > +{
> > +	*val = amdgpu_smu_debug;
> > +	return 0;
> > +}
> > +
> > +static int amdgpu_debugfs_smu_debug_set(void *data, u64 val)
> > +{
> > +	if (val != 0 && val != 1)
> > +		return -EINVAL;
> > +
> > +	amdgpu_smu_debug = val;
> > +	return 0;
> > +}
> > +
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
> > +			 amdgpu_debugfs_smu_debug_get,
> > +			 amdgpu_debugfs_smu_debug_set,
> > +			 "%llu\n");
> > +
> 
> That can be done much simpler. Take a look at the debugfs_create_bool()
> function.
Thanks for your advice. Will modify that.

> >   int amdgpu_debugfs_init(struct amdgpu_device *adev)
> >   {
> >   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> > @@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
> >   		return PTR_ERR(ent);
> >   	}
> > +	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root, adev,
> > +				  &fops_smu_debug);
> > +	if (IS_ERR(ent)) {
> > +		DRM_ERROR("unable to create amdgpu_smu_debug debugsfs file\n");
> > +		return PTR_ERR(ent);
> > +	}
> > +
> > +
> >   	/* Register debugfs entries for amdgpu_ttm */
> >   	amdgpu_ttm_debugfs_init(adev);
> >   	amdgpu_debugfs_pm_init(adev);
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index 048ca1673863..b3969d7933d3 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -55,6 +55,14 @@
> >   #undef __SMU_DUMMY_MAP
> >   #define __SMU_DUMMY_MAP(type)	#type
> > +
> > +/*
> > + * Used to enable SMU debug option. When enabled, it makes SMU errors fatal.
> > + * This will aid in debugging SMU firmware issues.
> > + * (0 = disabled (default), 1 = enabled)
> > + */
> > +int amdgpu_smu_debug;
> 
> Probably better to put that into amdgpu_device or similar structure.
Ok. Thanks for your advice.

Regards,
Lang

> Regards,
> Christian.
> 
> > +
> >   static const char * const __smu_message_names[] = {
> >   	SMU_MESSAGE_TYPES
> >   };
> > @@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> >   	__smu_cmn_send_msg(smu, msg_index, param);
> >   	res = 0;
> >   Out:
> > +	if (unlikely(amdgpu_smu_debug == 1) && res) {
> > +		mutex_unlock(&smu->message_lock);
> > +		BUG();
> > +	}
> > +
> >   	return res;
> >   }
> > @@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
> >   int smu_cmn_wait_for_response(struct smu_context *smu)
> >   {
> >   	u32 reg;
> > +	int res;
> >   	reg = __smu_cmn_poll_stat(smu);
> > -	return __smu_cmn_reg2errno(smu, reg);
> > +	res = __smu_cmn_reg2errno(smu, reg);
> > +
> > +	if (unlikely(amdgpu_smu_debug == 1) && res) {
> > +		mutex_unlock(&smu->message_lock);
> > +		BUG();
> > +	}
> > +
> > +	return res;
> >   }
> >   /**
> > @@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> >   				    uint32_t param,
> >   				    uint32_t *read_arg)
> >   {
> > +	int retry_count = 0;
> >   	int res, index;
> >   	u32 reg;
> > @@ -349,15 +371,28 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
> >   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> >   		goto Out;
> >   	}
> > +retry:
> >   	__smu_cmn_send_msg(smu, (uint16_t) index, param);
> >   	reg = __smu_cmn_poll_stat(smu);
> >   	res = __smu_cmn_reg2errno(smu, reg);
> > -	if (res != 0)
> > +	if (res != 0) {
> >   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> > +		if ((res == -ETIME) && (retry_count++ < 1)) {
> > +			usleep_range(500, 1000);
> > +			dev_err(smu->adev->dev,
> > +				"SMU: resend command: index:%d param:0x%08X message:%s",
> > +				index, param, smu_get_message_name(smu, msg));
> > +			goto retry;
> > +		}
> > +		goto Out;
> > +	}
> >   	if (read_arg)
> >   		smu_cmn_read_arg(smu, read_arg);
> >   Out:
> >   	mutex_unlock(&smu->message_lock);
> > +
> > +	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
> > +
> >   	return res;
> >   }
> 
