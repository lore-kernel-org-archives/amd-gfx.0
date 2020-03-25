Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74279C54FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4600F20722
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yhmenU18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4600F20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EBF689467;
	Wed, 25 Mar 2020 14:54:54 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690046.outbound.protection.outlook.com [40.107.69.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE1989467
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 14:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNDk3TDQPGDt9XvFMjDhGalvuWzjgUbTuUXeWQnHjgqbOSLgNb9iU99Vp6YgcGxOB9ofbBmCtdohZceugjV6rzZRlOWJGK22IXkOvw6TdY7EQMEu+YeqrI70lQt5QDNm9mo8+u2640fipN6veGwsgPWv5dJrgb0eYoFkZgL4CO6gqXbJt7AluTgGCtWnDC5ubGMn99UcDUxpCfXjblVtsjI8bMSH9+J2Qp9Tw41sJ1r7FOap3LPNs/4Y2TLKqnOBVHdRwk0kwuadSmQz3gHNEOPHRgVzllxusuuX4NAThpa9qEpg7oDKW5sIJldJcEXmIgAAQnjIz5vny8hxFOpPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cec22nAeKTzVtKs6d3TZCMmfyFbDrSqPWGAvQCHDr8=;
 b=WLFmNU4KcBZDc6bDEJsM2A90mut8vCMqclzrOOtzTqFUWkWZunwzqhzXplQlCvd/5fID7UrNRwdT19/t1V5a9C/uKiVIHJ/RWQskRiSu8QZXva9XxoAHmtsjhe5QhxnE9jyYzY1vrgFZ5ba0A1SH/LunJQU54c4MmocdwoHSXudGy12ewXqdqRC7pC3myBN4VVKX6Rt2+SF9InKT9AD/yXlS//wY4BPnO2E+yInw1+31xutJ+CnIoTCx1uZQON/Cfj0iehCm73H2DHDbJMayVhN1fHLVmQAOgbOsotSZA7yv/sDmgAI0KJwPsMGgAVfJPTZTmIKE19kieUV86BjvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cec22nAeKTzVtKs6d3TZCMmfyFbDrSqPWGAvQCHDr8=;
 b=yhmenU18YBY5a2Z86yq2owz0aTYA9hjLN51n7AiVcbXsQM4EkLtYSRliSRh1mFwfRtHzj/y824FNlJUzOW9romdn/6jqSprFySdMqzymdD0ZE6U8o6mUxuq0HzQm0Z2SOvR1vcS1GbIror4bRxA/VmGsxTSNiMT2K5dYYMEj0cM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Wed, 25 Mar
 2020 14:54:52 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::9505:d766:9ac9:2bfd%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 14:54:52 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: Add AQUIRE_MEM PACKET3 fields defintion
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1585146580-27143-1-git-send-email-andrey.grodzovsky@amd.com>
 <1585146580-27143-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <c7d9c801-87d7-f15b-9148-e52d4a2ed7fe@amd.com>
Date: Wed, 25 Mar 2020 10:54:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1585146580-27143-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::34) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (108.162.131.176) by
 YTXPR0101CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 14:54:50 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98beea06-6c06-4ce5-307b-08d7d0cc78ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB3147:|DM6PR12MB3147:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3147C481110A9303F6A61E8399CE0@DM6PR12MB3147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(31686004)(26005)(16526019)(66476007)(66946007)(956004)(2616005)(44832011)(31696002)(186003)(5660300002)(66556008)(86362001)(316002)(4326008)(16576012)(81156014)(81166006)(8936002)(6486002)(478600001)(2906002)(36756003)(52116002)(53546011)(55236004)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3147;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Md0Rtx+TJVkgarke4NW3qm1ub2GDl7Dv5g2sPHSF3uQdirfNozi79U97arRYe5DrD+LZyKcveetX3Nrpsu+AEqTg2Bgil30bfS/R4d3y+LEM8TKhIBuEbxF2eQXG658sRNYjKEEXvu9dR+EIMf/GH+0bOztD2BeD+fmiKLp3/De/VAGysMqYjLkHs9I80HB2K0hdsVqwCp5VbH0kRctzWmjUn7k7ZGVIP2ujCBDZQ5YlaJBSCwCHyl+SltAF78Pf/VBuU5YRst7TVFcxgE9KeSJvz6cVl2Wd+fMY8OmKrr8RAznPvVn3LH7sic0ynQOtqzVIO/3sHwYpjSi0RRNZ0O09WHGqF/uU3wiLZQdQbjbjDbSaClD5ARZ3DLnuaSjNadecxchimXQ01N4jJRqtTu3isK+aMED3lETdPUZ3JP4fM7iujpmhXm1mE5f6g2NE
X-MS-Exchange-AntiSpam-MessageData: 9r8CRPWij3nDHOiJE5X4BHtWi3j06DuC0bKX6qfcCUQ16JgKe/ugBOdeFI4+MCiKjPLZ/okvkExsi2zl9DrjF+Trz5by8Hg6rZ1LeJgnuMK3yDyGmsAqfDBksuk4Sm3oyTECQxQ55aTiNMj8+80Zow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98beea06-6c06-4ce5-307b-08d7d0cc78ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 14:54:51.9536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVUpIv/OjALEYIOpCA+ZJ3ybEO1v0vH17ncRoR7f2PfaoQv+Wl8+gBNw6TzLkLY/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
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
Cc: Ken.Qiao@amd.com, Marek.Olsak@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-03-25 10:29, Andrey Grodzovsky wrote:
> Add this for gfx10 and gfx9.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nvd.h    | 48 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/soc15d.h | 25 ++++++++++++++++++-
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
> index f3d8771..7785ea5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> @@ -256,6 +256,54 @@
>  #define	PACKET3_BLK_CNTX_UPDATE				0x53
>  #define	PACKET3_INCR_UPDT_STATE				0x55
>  #define	PACKET3_ACQUIRE_MEM				0x58
> +/* 1.  HEADER
> + * 2.  COHER_CNTL [30:0]
> + * 2.1 ENGINE_SEL [31:31]
> + * 2.  COHER_SIZE [31:0]
> + * 3.  COHER_SIZE_HI [7:0]
> + * 4.  COHER_BASE_LO [31:0]
> + * 5.  COHER_BASE_HI [23:0]
> + * 7.  POLL_INTERVAL [15:0]
> + * 8.  GCR_CNTL [18:0]
> + */
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)

I think it's visually better to not break up the "#" and "define" and
to not bunch up "define" and the macro name, to intead look like this:

#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x)        ((x) << 0)

Which creates visual cadence, for the eyes to follow. It also creates
a vertical visual separation (reading down) since then the left column
is not just white space reading down, but breaks at the definition of
each register field. (once changed for all, you'll see it)

> +		/*
> +		 * 0:NOP
> +		 * 1:ALL
> +		 * 2:RANGE
> +		 * 3:FIRST_LAST
> +		 */
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
> +		/*
> +		 * 0:ALL
> +		 * 1:reserved
> +		 * 2:RANGE
> +		 * 3:FIRST_LAST
> +		 */
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(x) ((x) << 4)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(x) ((x) << 5)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_WB(x) ((x) << 6)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(x) ((x) << 9)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
> +		/*
> +		 * 0:ALL
> +		 * 1:VOL
> +		 * 2:RANGE
> +		 * 3:FIRST_LAST
> +		 */
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
> +#              define PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
> +		/*
> +		 * 0: PARALLEL
> +		 * 1: FORWARD
> +		 * 2: REVERSE
> +		 */
> +#              define PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
>  #define	PACKET3_REWIND					0x59
>  #define	PACKET3_INTERRUPT				0x5A
>  #define	PACKET3_GEN_PDEPTE				0x5B
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 295d68c..8983871 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -253,7 +253,30 @@
>  #              define PACKET3_DMA_DATA_CMD_SAIC    (1 << 28)
>  #              define PACKET3_DMA_DATA_CMD_DAIC    (1 << 29)
>  #              define PACKET3_DMA_DATA_CMD_RAW_WAIT  (1 << 30)
> -#define	PACKET3_AQUIRE_MEM				0x58
> +#define	PACKET3_ACQUIRE_MEM				0x58
> +/* 1.  HEADER
> + * 2.  COHER_CNTL [30:0]
> + * 2.1 ENGINE_SEL [31:31]
> + * 3.  COHER_SIZE [31:0]
> + * 4.  COHER_SIZE_HI [7:0]
> + * 5.  COHER_BASE_LO [31:0]
> + * 6.  COHER_BASE_HI [23:0]
> + * 7.  POLL_INTERVAL [15:0]
> + */
> +/* COHER_CNTL fields for CP_COHER_CNTL */
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_NC_ACTION_ENA(x) ((x) << 3)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WC_ACTION_ENA(x) ((x) << 4)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_INV_METADATA_ACTION_ENA(x) ((x) << 5)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_VOL_ACTION_ENA(x) ((x) << 15)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WB_ACTION_ENA(x) ((x) << 18)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_ACTION_ENA(x) ((x) << 22)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_ACTION_ENA(x) ((x) << 23)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_CB_ACTION_ENA(x) ((x) << 25)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_DB_ACTION_ENA(x) ((x) << 26)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_ACTION_ENA(x) ((x) << 27)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_VOL_ACTION_ENA(x) ((x) << 28)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_ICACHE_ACTION_ENA(x) ((x) << 29)
> +#              define PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_SH_KCACHE_WB_ACTION_ENA(x) ((x) << 30)

The same sentiment here. There is no reason to break the "#" and the "define",
which is usually seen as "#define" by the language. Instead keeping
the "#" and the "define" together and then white-space to the macro name would
make for a better and move familiar visual cadence. Like,

#define		PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_NC_ACTION_ENA(x)           ((x) << 3)
#define		PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_WC_ACTION_ENA(x)           ((x) << 4)
#define		PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TC_INV_METADATA_ACTION_ENA(x) ((x) << 5)
#define		PACKET3_ACQUIRE_MEM_CP_COHER_CNTL_TCL1_VOL_ACTION_ENA(x)        ((x) << 15)
...


>  #define	PACKET3_REWIND					0x59
>  #define	PACKET3_LOAD_UCONFIG_REG			0x5E
>  #define	PACKET3_LOAD_SH_REG				0x5F

Like it is done here ^.

Regards,
Luben

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
