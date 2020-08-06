Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A6CC433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D872177B
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F895cGzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D872177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937F16E90B;
	Thu,  6 Aug 2020 19:21:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14D56E90A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 19:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMs/npAX21VnB2Qyu/FwiNAF0w5v8y1Rhu6JWj36HhyMWltvzChppNahLVuENC3JzD2u2mz0e8lwbeL+P1O67TyGk428oX1ZZq0bmnQkk+lR+jqC2V20pfBg1MRUoF7lt6bZN33Mvg6ivC6hkveU2shGc4WSQc/NA5IeqZDzalZ4Ny/N35TMSLzciJlCtg8X8fUP6w1/cFmbPXtHMKCiRuIvMKMD/BZ+2KLBfRQqnrnGNRs4dCazC9+gWFX3b6fNHcM2sM+70jtXDSw0/wDSXrsnMB12jk14kIocw9L37fIIOg8KnxQO0OjpufxHW98bJdtKef/HvKfIXt8f2ZGqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUq3szvn2eSKruH607IxTrglbpMYEVKcssST2o3D268=;
 b=oD31TteokGIzOTZw1H2VNwdQh1mP6Xiu9WOLNxb5g8ncRxXkjRLvu0zNV+5zt377KzR7sULq31h4oNTjKBulOYa6fvtmdU45k14yMxsu8GueM19sSEOGSkJ62PpaRupnPpUmMhwDuZKb4+x8PiWz6YuCOFUohKziM+1qLCcnifX/RRZ39Y8Lq20OG2L1Jp4Ta7nRqLKaDXO8GnqgTNpcNqKQikk2uJ//75k/QtTGt4IJ/gRkMKBjbcAl2dvexe+ytQXm9C6MHeHPjuxcQw9zZJGP/cmKiSEznmVeoFa8jkIu+xyRiOIrVkgN/qy60+7fL4Jgp6gxXiuSoHha5Q/F4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUq3szvn2eSKruH607IxTrglbpMYEVKcssST2o3D268=;
 b=F895cGzt7O4NFs58RU/dICN5DTR8ZvoDcFcijSKx/uWDj5vL4EK8nIK4m+hcF/arFOnbaHwoY9ITz4JwPzz9/wJuLObvD/2KzSHaD0g5IG4RS3Xi32jVj8d2p+HsdsPhDNEINzCn6aSt1ti01qOZjUlsQvwP3JHVLrn4P5ilKuo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1162.namprd12.prod.outlook.com (2603:10b6:3:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:21:34 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 19:21:34 +0000
Subject: Re: [PATCH v2] drm/amdgpu: unlock mutex on error
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200806013152.32747-1-Dennis.Li@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <b49047bd-7aa0-3ac0-a1d2-6c22724a1270@amd.com>
Date: Thu, 6 Aug 2020 15:21:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
In-Reply-To: <20200806013152.32747-1-Dennis.Li@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 19:21:33 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcb68133-619c-4492-78a7-08d83a3dee8a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1162:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB116290A8DD7A51110909A98799480@DM5PR12MB1162.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60WM1j0DAdlzlzXUweEJqrS/2pNsQQ39eDK6GqvGjcoc+BedQEEnfF2AMidQlsucrYR83z18Tfz/bugPuwVlbYTDDy5qIg2+wGODnqmemdFYOSh0y5wQf2GceJNsPClurvxpACFX3UhLC5/n74thqkpt4gCew4q+X/Mib77oOLBK48nAqcr+cba1kyqjYnoXlsE1qxLWDTf4XXsn5KOBtE6awpUr8fYbCasHTCiU5MMmrso2fAr2CRfD1VQgFirwZJyAZLd+H3JFTM3xIzJp/sjq9eFYddp2MwurvyvBXBSHpsor7XLuZit5JifE44rQVCEa94NV1WxKPVTjEDg71jSV/T/nqEd9/wSE9w0r2jW0WbvqnKC0wbiGRgqWITO4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(66476007)(6512007)(8676002)(66556008)(66946007)(36756003)(8936002)(31696002)(83380400001)(16526019)(86362001)(186003)(53546011)(5660300002)(6486002)(478600001)(44832011)(2906002)(6506007)(316002)(26005)(52116002)(2616005)(31686004)(956004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0PUoQaiErYAvsXG+VbnLM7yomD7h2GGgzAGZrfHKZ3U6xTdWoAphunX5A8tLyVNZbEtVN6kJhugCAQr6TWknAc8O072f/9tGbNL4gqcPQlD7rOlwsFr9NoVfvtvnezftTmUjp9F8tkdCrj1kAbz5CGkPZ20VnCVhvwgAj9hbd8GQ+UEsjtE5msBNqeWAmfGkASWbfH1N4BCpOswtik8vTx6NUZ4Q/CPasBbh7XyyYfxB4QqRuLGPO5tX9ULMLteYRoKxM6gMLE/RamAP5QI0/eKx5YwHDMXaNj1oMswR4ow+f2Y5liDInQep/wGzerB28jeoNSRM0B59wcOC7/C7IDvM1UyolQ8oa93bJ+rMeKHXGxPKnoH+3+SNbRJa+0uzG5wfJglmR5lhWN2/VRq+xHsc69e+ZMeLQypAFGV8NIIppLX6hBlZhQXpKOpOXlBlP+LaDXSOL3ZUBBbH4Grxmxw0Vt/VRBw0rlsU+9Jx5K3UJgkLBRP5YOpZzNPcIRKM4LK/G3GyuaHeegAW5FxbSfFyX5isBks9dKMCm27VvGq3JhcIBy15gPhsZ1MZJzXQGQPw2oqCl9n29cCXXwWLOOmmxIgdWceFEmVz4oVuMEtqbDXlOqgHto/Lvdl6GDYOhxCkSyKk8yCPUVesSm2pVA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb68133-619c-4492-78a7-08d83a3dee8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 19:21:34.4632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzAV7UwQF3eGRfFY3d56IZH9feJuiA2a35UNui02viHFe/Jy6Fl7O53JzXc1sPIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1162
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, that's fine. Thanks for fix.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-08-05 9:31 p.m., Dennis Li wrote:
> Make sure to unlock the mutex when error happen
> 
> v2:
> 1. correct syntax error in the commit comment
> 2. remove change-Id
> 
> Acked-by: Nirmoy Das <nirmoy.das@amd.com>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a0ea663ecdbc..5e5369abc6fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -632,13 +632,14 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>  	}
>  
>  	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
> +
> +	up_read(&adev->reset_sem);
> +
>  	if (ret) {
>  		DRM_ERROR("amdgpu: failed to schedule IB.\n");
>  		goto err_ib_sched;
>  	}
>  
> -	up_read(&adev->reset_sem);
> -
>  	ret = dma_fence_wait(f, false);
>  
>  err_ib_sched:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 4e017f379eb6..67a756f4337b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -545,7 +545,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  			}
>  			ret = amdgpu_xgmi_update_topology(hive, tmp_adev);
>  			if (ret)
> -				goto exit;
> +				goto exit_unlock;
>  		}
>  
>  		/* get latest topology info for each device from psp */
> @@ -558,7 +558,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  					tmp_adev->gmc.xgmi.node_id,
>  					tmp_adev->gmc.xgmi.hive_id, ret);
>  				/* To do : continue with some node failed or disable the whole hive */
> -				goto exit;
> +				goto exit_unlock;
>  			}
>  		}
>  	}
> @@ -566,7 +566,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>  	if (!ret)
>  		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>  
> -
> +exit_unlock:
>  	mutex_unlock(&hive->hive_lock);
>  exit:
>  	if (!ret)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
