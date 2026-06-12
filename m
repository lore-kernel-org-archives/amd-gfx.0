Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4033CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 07:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF3510E2C9;
	Fri, 12 Jun 2026 07:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FTFTtkbS";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7106B10E2C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 07:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSTNdpBHJTe+z+6A3+BkSAZtaIgblQg4TUBs370YD7QBkR8sH5hNI0gNVA1zDCI8mVDhcrQjjgKXWEy1gIbZLdkVB7IRmqmeBeJhnvo+cKwvGSus1vk0+CY7oWt98zBCePgjazmd8+VSWS9fpOsN0VkNsRmUa9qvGnt76qHEYcFANSq+n2kWrQD0D+RAuPrr3fiwBlIqaSIz3QyKGSZTgtQlFKmN50Rhz60aFht7/wq+szZX1KH+/xUCcaaISTqVtTrFZiaSJB1vlHBk1cU5ZY4BIsPYep+FoPMXBk7UZgBGou+mag1qW3MbMJnsTnVUG2aHUOqVxLxma0QLy3JieA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYhrsvKecr+QE8WSIC1WC/j3feZAcmQOHWj2rCRUyi4=;
 b=afxdzptv3KhFhTtTH0ZAPl7F8GfxRBKPeo9W2gGbXpW6ZJtKRAQ0zaYwdMF0lf5ni67LX/nqhATq/t/AbtTsi6x9GnUHZqBPkTvzFOCbuIZC1OaoDpnhIiZ8lae2H4HfTuAw5hIJyBGv/RU+da1XBjIkH7WFImWsWBhOmoVwYqVPAT1x87qTl5CBwAee1aWoIIug+87WIDaAaLFo27r/LjfdY3DHKPquPpTalodGrkYWQ8Ddo770FFjyxOerP2zOsCskdqVwyA4QOAkO3tg+K+mYKZeprYI7byJPYmLaP2YXZClIMcX8SrRFsDc3mVMOE+v2f6g5I8z+62SS3khvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYhrsvKecr+QE8WSIC1WC/j3feZAcmQOHWj2rCRUyi4=;
 b=FTFTtkbSIRkf9sW6499QjoJ2KN11DW55BcmeAFcrPjFajBOzcs6krPDepi9LIgZ1SHPIW2Ss6/Rbwz/GYsIFpFi/2Jw1Op9c0GW2IbcpA0jWrkZW9AJJcjX1iXgZHd3Pd2o3/J1HLMnFJprFvdZFR0WGw7c1M/STqU80WomMxY0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 07:33:15 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 07:33:15 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amd/ras: Sync bad page count on EEPROM update
Thread-Topic: [PATCH] drm/amd/ras: Sync bad page count on EEPROM update
Thread-Index: AQHc+js8l7pAx7mWO0amuGpQpWwS47Y6hvjg
Date: Fri, 12 Jun 2026 07:33:15 +0000
Message-ID: <PH7PR12MB87967EBC995C92157F9BCCD7B0182@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260612071426.1615878-1-xiang.liu@amd.com>
In-Reply-To: <20260612071426.1615878-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-12T07:33:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB7142:EE_
x-ms-office365-filtering-correlation-id: 47827dcb-2e3a-4e33-6810-08dec854dd9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: jsJZinrGmAg1UGsNNFT6deR+75iginBAXWF/yoxM4F2mln0bhJEC0k5Gkja4ZciJDN1IqmINvYj9aZXNvrHLPkcrnm28eaoHY+0wdl8hSgs+3gKBfxYStxkw4KvxKsD0P2UhQnPr40yKrX8PXIjVCJq62CiqM8yO/tEE/A5874g21A9h994hZmoEGpyWfh/8s25BvxCXSnzWVqzQfcs2VkaXahqyjg+hPGL3nrNJ3gu7NVoq6yz4PZLUfm5ziDqPg+mmwGnzQRM5mo5AzSLYAglMcAFtx+bfnMD0SvVV5GkQswWlReBeUNj/1BVK3JAlfyobklHbZRhDMhMmKvMmLr2Y5ru7mdMf32/7J+J1sZFquBV9N3zoaReG6szhpK1o6DytqipFanXxt1ppXIp19wT8sayY9oxXQgosps/5hnIJpo9vC5+zIlc+SR7AF7Ub+E6fFkEjLtqXj7GrpyJw8mHMvzHXRSAYjd8wAdMBmLYwLCnX0+jjShDvAzD+cGoupRhMUI/B0RCZKSk97e9Y4H5LZzue4yw0D9KGVmL/mzH05a2nC/iAHQt3QcNNSjS3skbfGML7bco2BSQK+TuG2qoD1Ha89yQWqym70AxAekDHZJJf/qJFcf4F33QeqL/MmMI6UwxmxihxHvxqo+ZzXELkTJdmlexzGSfBcHzAzSxCAp0EKOn1SfIp6VN0Bm6QFXYcnV/auwkH4tmBjHhHmlzd4kknF5fz4FBjSxofEYpF+181mErwlFhSIBu9lXmr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IFT7xeoZBDPgFWSX83+BbE+A/wYSUsRBipWTxS5hxE0PYayJE9BxGGDX9RQR?=
 =?us-ascii?Q?3ICT1y8OSiVOZXU4Ps9uojVi9CDvHq9tY1Fa+MhJmUKOUWtfKMVhkWC4QW3b?=
 =?us-ascii?Q?yRmctOziEiBAUKSru/rvkKCvlN+oCViKYUdgLeXO8ysRQU91wntyj5NPsZ2V?=
 =?us-ascii?Q?w5SoAC+m7TA22pnkqn09vQlPrffEuakR9Oi8emmwBQAj7QZ77v8PP9F+kKKr?=
 =?us-ascii?Q?49VylLQOFR4DuWwbF9bX0SA01QVvf6mwf45Wkc2ZROU2XRStkwGs7DgdaV/G?=
 =?us-ascii?Q?nJvS/pSA2/vS9qEqoWyTBZuHvCyKBef1hxIyd6k9i/HX7hKpNFz8tww5i2MW?=
 =?us-ascii?Q?z7GmlDwac2ZVWJjCbL24sfhW670moZjvS8nu153iKAwLnoTk+F9wKq+z6mIT?=
 =?us-ascii?Q?aUmLxpugPf+Yll9hAfkK9KYs+XDFoqfpj1Bi8x8ZUM8w0X2J/iHy4ZZ9MnJZ?=
 =?us-ascii?Q?PJ1h6ohQCyzOR5Ay82eGf8IgL9x6DXV+DoK3ipgm4od26MJhTc0+wTL5WOuW?=
 =?us-ascii?Q?8ULmaOFNutwMkQzkLnyYsgapFC+vRqgHW+M9xzZ3zjKKaIyXp1vDWeolZVG0?=
 =?us-ascii?Q?LVCUR7z6NeK5A7nRphaZt/0sXpBOpLz9YSzizBAX1xO8gXEUTa9uc5X03KuL?=
 =?us-ascii?Q?6ty9tFZpph0CoDkfJXKVK8XDG8JudQmd4O1+9leRSUXTQRTLMksBdsqG2fYh?=
 =?us-ascii?Q?6FMIcEOTpsFRci0fvN9Brcqt12WA0flF9nlFc2YtV6CiCMeEjci8eTesRrDV?=
 =?us-ascii?Q?mg1iMJekVM+c3iAMF6c1Bx2+sKNXAaU5me9sDHP5vSjhA2e1xToVRiOi9Gfn?=
 =?us-ascii?Q?wSZop74VIBR//2fu/xhPvQSROwDfl9qPZm1rv1jEsT9LDZDEB6V7f4GiV1Pf?=
 =?us-ascii?Q?gWyBtxHVO/lxZFJvBcURAbdtMLnMlfrsJYaOizMJHUVElzIHYw7Sw136dmZW?=
 =?us-ascii?Q?vFsUlEqPWFP5YSB6M5qJ9CW697c7pFvzkZrbMgWs5UZEvgQBkJBORwQgpt1n?=
 =?us-ascii?Q?O4hdur/NvNbOJkLyxkj44ZRxfufVg5pvRm3ErGwl7TFblyFrfxzDDaR+mE/6?=
 =?us-ascii?Q?Ns+dAjgek69GxXhLBWZX0yvU4df27G1fOK+g9fUCPSHm27kup+fWhDo2GZOd?=
 =?us-ascii?Q?KqGAuoxCnrh+G756upuuxURf0lReZiWwICyHV1IfH53gd8YrBlDCOg/NAVPX?=
 =?us-ascii?Q?N8pjkHXFWFzyS4rk/Cb6ojPD8LjW5WQ6Q/lLyB83TpIx5KhnerOU3uvtCx9S?=
 =?us-ascii?Q?si4nRZp8TLw5kdEZEqpZLcMtq6QSuN7afSm1NEZlym8iyq9FbzwFqlArxEYe?=
 =?us-ascii?Q?M25tuYQb6daDejX392HN+isGEihn6RSWpAp62Cmhwl+zYprW+F//akMAr3iR?=
 =?us-ascii?Q?OQ6Ry6Zk6BHh2X07JFk0afIOgODfrSpnYs0gBOu3iQRGA5Zp19SttspXAhvU?=
 =?us-ascii?Q?E8z6EA90KsYnW7CWcb5QXArlBRUzLNtSGR2ySKSsS3C/YZTHsA6Gd33jFCgJ?=
 =?us-ascii?Q?fhldneSaOm/GhHyvho4tW5CjX6typnW4uzLTBA4wh6AgJAeffmH+9C/0UjlI?=
 =?us-ascii?Q?3su4uOW+b+C99Gbb3JmWpaGsXbkcpM4spTav4gySaYmjWlMRq6NAIkp5jPkN?=
 =?us-ascii?Q?CDZAVpiNwSUbQh/tFxveZPOoLdUFnSAf4R/6XNhyQu893nV9L/ipinQfDN4k?=
 =?us-ascii?Q?84+i0XXs332Siq/YAC27mouaegKx2DaZ/80mt5ZyXpwr1+5c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47827dcb-2e3a-4e33-6810-08dec854dd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 07:33:15.3664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wbaj89L4spikgmRXzwEPF9b8V/9A/eNfjWVZcYl3onnqEwUOd99JlHwIW73s/NAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Friday, June 12, 2026 3:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amd/ras: Sync bad page count on EEPROM update
>
> The rascore EEPROM runtime append path updates the saved bad page count i=
n
> memory and EEPROM. Keep the SMU bad page count in sync when the EEPROM
> header is updated so firmware sees the latest count from the runtime thre=
shold path.
>
> Notify UPDATE_BAD_PAGE_NUM after computing the rascore UMC bad page
> count.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
> index 3a0ea036c9be..62d1a319c08c 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom.c
> @@ -746,6 +746,9 @@ static int ras_eeprom_update_header(struct
> ras_eeprom_control *control)
>       int res;
>
>       bad_page_count =3D ras_umc_get_badpage_count(ras_core);
> +     ras_core_event_notify(ras_core,
> RAS_EVENT_ID__UPDATE_BAD_PAGE_NUM,
> +                           &bad_page_count);
> +
>       /* Modify the header if it exceeds.
>        */
>       if (threshold_config !=3D 0 &&
> --
> 2.34.1

