Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8766ACCA470
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Oct 2025 15:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0450210E6CE;
	Tue,  7 Oct 2025 15:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+bLA2Z6";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B9810E6D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Oct 2025 15:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0j0OPwwG9+R75NczbFvk/Tt3w/6kHI07cwOAzgzD2NX5XmuuEiBBIPvUwYTLg8Ai9hQQ7gGdo6z0nA/ayrKgRnaOYGUIwB9PLX+gtqTTwk/VdIiFTkeFwPUqcPBfDAaRhcN3kpD4Q+NP2RfFK8SoZxaLz4cLu9TqVXXd93KhmZVLecoUoG+gUisAfFXfPbq7x93EkkxSdmnGmBvC2KR4MtXKwLG+5LpkXRBz45SNUBdFWohD7+bgKfAB2GQ3SWuzT/hD4Z/IXT+cWhJMfKO/RaGOB4cI/kLSbgRN6gg6oToQlo1q4DcDN4StGHcdcQMmc004Lk3V70rysYXTXC8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ki1uMSv4ilDSggr1K1Pgj47+PsZ3I/qz0KhgRh4eps=;
 b=dRiP8HhyNc33B0F/y59zyeKSRPyQ0J7UDV+q4A0ORbNG0dM8IClxf2TkGhIlEhBjEsff/s39VrNf8opqG1ugNyF5/0cfXUhq9o3cbJ2KhkVFNhwG4do5aKsrpCijLgLbKgZr/dFJjVFoVkuqUWH/0uHSJrGB/IxuOQB+F26s5Njgno3EbJUFSXQr8LIWthj0fVu7b3+EWtVO2OdtBnO7NrQtjYbCMx16GDmbnl/c+sZw7UqbFAa5Ttakjkxb2vSS+8cNclQJgXhCKX8nqc6Z+fo3VNIN7AT7K+KBuYoypkkJNUGvPORqod9FUxrYpCiJiq6zasJjlhxYaIZS9x8v/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ki1uMSv4ilDSggr1K1Pgj47+PsZ3I/qz0KhgRh4eps=;
 b=r+bLA2Z64bd31NiH5keL2CTn25QkfFK4UheieuHBN4WRVkZ2sEIlMg9EPuKnDDblX2TLBQTvgYsMbzYHXGpbnAhnrKDGsPQw1kZOZNUsISBGaR4fwJTmU6PGI6MRbhEAHdXtDlRTB/4fUA3lO7+7Qa40V/Nmn95RN5+ZmunpHuk=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6062.namprd12.prod.outlook.com (2603:10b6:8:b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Tue, 7 Oct 2025 15:09:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 15:09:30 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 0/5] Adjustment to power limit setting
Thread-Topic: [PATCH v3 0/5] Adjustment to power limit setting
Thread-Index: AQHcN48rSgCaG5MQsEyb+iCSfHY91bS2yWwQ
Date: Tue, 7 Oct 2025 15:09:30 +0000
Message-ID: <DS0PR12MB78046EE4904C39A488721CE997E0A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251007133438.39411-1-mario.limonciello@amd.com>
In-Reply-To: <20251007133438.39411-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-07T15:09:27.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|DM4PR12MB6062:EE_
x-ms-office365-filtering-correlation-id: 5bcca35a-5fca-467e-c626-08de05b38435
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1xIaOwTwunpHtAUfH3NMUDMWYGxJ0u+6LQdrxj7o27M1nLTB7Rbdsu5Gn2yu?=
 =?us-ascii?Q?H7gDlOCiP33OholIIqPd/FFLkctZJvy9Oir5E7qL2IZCZG/LC9NF5wLEsEF+?=
 =?us-ascii?Q?4w8pc242nTI6ekO/uWlwj9x6+25ARITbRjPPM3kVy7SoITvbHT3T9HAZxj3+?=
 =?us-ascii?Q?ojwED7X0BcacQ3StVsgxTcqdcTxIUBYqL2hfysWRtK+ny0vNC2JQp1tgW2Wb?=
 =?us-ascii?Q?lEOXWALFy8aU3+rR+I2nHAax/afgUq7v20Vvq6vimIqI42rhCPKX8qYMBXy1?=
 =?us-ascii?Q?7QntRa30AaaEUOJKXrQm3nOqHBGOnMJT+hZRAbzChg9z3w2zrWBJWK5Rre5r?=
 =?us-ascii?Q?ZvVkB1sp2qztWwUEOnjCNU6K3btkymZdLmsHmwICbI6FsqDYELC0I88Il8E6?=
 =?us-ascii?Q?3Iklo60vRQ+RuiSJgrPE3f1OdEzj7ISihAALxVfc6W65ZNTrf33rYUp2PhgC?=
 =?us-ascii?Q?Me7+q0AVzKH95shqT+YT7ckauArOmVO4xLXu2vkRvpPMTlT5bag0RBqb7SuF?=
 =?us-ascii?Q?HSLfaRHJf1WGZLAbHRlzZWD/y868yL2F5Nhap6R0KMhQmbGaWwzlbIt+h6yb?=
 =?us-ascii?Q?zJ4OXnqvkh6vgkxTtJjeY+TyG0Zok3tzTOeO7WLU6iZAavjjnToMkt+Ewk/n?=
 =?us-ascii?Q?umrhQw2T+zA0GoJ1IsKnizzcz6YDzgyWpMd1j5lJ7HkovTzibqm3HNa0xEm1?=
 =?us-ascii?Q?ZN+awrx43kutjanMpONFMHkL0aEOjpyIDqr3KZSGsIXSJMdU7/FugFmRV45D?=
 =?us-ascii?Q?YpCGqveEjeibwDDWnJwm4s8AWJxzE9bu6LUBssu5V9dXxBH1dDLP3v2u3UVi?=
 =?us-ascii?Q?9i2lntL1btPhPxdN1Jnvmt55fJHVxQWGAZXiQpi/zpWsV39s9nK2n+55yqS9?=
 =?us-ascii?Q?2N0JZvnWzwfR0eDMv9OcYnr+Rceh6IkEFHtGbaGATiEA1imm6FXr9Gwbs+bP?=
 =?us-ascii?Q?9UFq1ZzcPxEZP5cZUX8k7ocg2bo18Nmi6/8IE1Djyv7DYiF/UYSUtVTRUVE7?=
 =?us-ascii?Q?5z2bt3tBoFEFnoyQu4QuH0myTo6DtuDFa/vPdT7nDnM5rLc5CKQ1RCpIghoC?=
 =?us-ascii?Q?1R7d+1M6prJz1SdpAldAPjOERnfb8lWyjSnga+afvrc3LWHU/PgUgWyLlnNG?=
 =?us-ascii?Q?3ahKWwsLbOeDNYc30BVVXknuDgS5OnbKnY5+mlIxklvIjy/+4lMQJGPo5X/3?=
 =?us-ascii?Q?onTTe7dk4rqFESKuuO2WvhL6GRNG7YfTGYA8B0FRC1PAUxfbJV3+l+Lw9xc1?=
 =?us-ascii?Q?LM6Gn2Nod5KZ7tETiqeyq+315zYdXAUSQAmKFW8JxE5ALWQ604uYJRbA6ZcN?=
 =?us-ascii?Q?edVlxNYBOtfIovl8Wh45TaZ4aAWJ7BtJN5EZ+zDMDC7OBHFsUflMs5Frqt1E?=
 =?us-ascii?Q?HyODVKkomrJubPdOGKwAizGB2dVaFCEba/9n9g92yGl43ezG2SX/rvP7mvXt?=
 =?us-ascii?Q?WgpAjWd9OSK4rg0hGtVaZoB2b4kp8dopDND6ySQ1/U3zYyzoD2cGAamHx/lX?=
 =?us-ascii?Q?p6J/wwoAMuFdY8cxtYHu2KkoSECzU0mq/5cn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4zUyNqChr132dVIzfR91JAiKK+++N8ZtJ0iVuemh63VLdMiw0PuPbO/AWSwM?=
 =?us-ascii?Q?k7u0vP6rcHR4hyLtZyX9YWU54LPnREgxLNe0Ju+Ys+Uzaomu0n2xFkJorzaP?=
 =?us-ascii?Q?Obxsmru6BwRxlOUDG0GrD5UIda57VhMoQNrhgds0AbWJ2m3E9yleBjqf+mOA?=
 =?us-ascii?Q?Cj79MYRoldRLVqSIjoRzc+9gBhJB6Phjp3F8bum0jqzKtaT98xbLtOBdeCxB?=
 =?us-ascii?Q?+eplPOwhX3cVYPUnlopmErIBxEqNvJNbc8mIXKesmxX5GlJwAiCynaoAfvIw?=
 =?us-ascii?Q?yZIi1Ci02/PnLm9hunckTfFI2q2ylXwtL+jkYddPXZ8ddnQbmNPYCrtifAi0?=
 =?us-ascii?Q?cvpUf6Ny9jN1VkzbLIDup+mtd4Yo+dGHo4MhA1HEFuJd5ov2zcnbJQVtxcxH?=
 =?us-ascii?Q?us0G8tl7VPlWnZy/IFN10gqaDZ1ydvuNWwJw7Bevd4zo9bVZBEq2U+IDBQdU?=
 =?us-ascii?Q?PpcIIgqbGkPnfxxBr6j7frMsulhUXAq+0wL94XJt5udv87Ef+Lv2sEO4vWQ9?=
 =?us-ascii?Q?nhFp4Mlfzh1LU0Ubs5ec5SbPayR36ez7XPnZvmyVzaQ6bStE0N+iD3cCfXMw?=
 =?us-ascii?Q?B/gx3GXk79hRgyrLHjKeQGmEfbWLg0NQXUwDYzMp0ixA40ZX0vRl922pqD8m?=
 =?us-ascii?Q?nM1NAxROlUl+TtkVQQkGCJhr9OVjgV3M13Kak7npoHs4vhRGThC/r9UbMpAm?=
 =?us-ascii?Q?QPuURdbyhaEhRGrmqz//Cnv029nJfrysejnJcs+NFYOyT/Zz9vfwIAGnBmur?=
 =?us-ascii?Q?c/uclRKHBtYC0/OJa7FjxEk/llOHtfEyOl2fo6xm8hw1l2I/AfINkTACHwQz?=
 =?us-ascii?Q?+IIT0t1MYLSWEJtTPxWRUNdjUolatuMMbVIzkPiTgOIxRteBrTUg5kmw1pq2?=
 =?us-ascii?Q?sr+Jzyczla63VBBJAGWwrfZkOs2JYNeiKZI/WF9j/FZBjUrJcqu4VCl9Y7qi?=
 =?us-ascii?Q?S1/NJJRH4iMzOjzAOCeeo2mkzKt9kG36RwGK3mfDxlnORDHPNi4DjYHNM0Ps?=
 =?us-ascii?Q?wav12H8wYM/HahXUVhyL96uL6E0hKdBCPandVGJr7wsScDjE3OqXi3yXqK+w?=
 =?us-ascii?Q?tLGmmGNx9CvGoByxQX67SIfzxomRSTg2QsrNswCk5TZbgKQTmhmY3EHNvhMP?=
 =?us-ascii?Q?kTQ9KoiWsmIe6y5VdiGua1uoOzKogAAvKUNsLanurmL/VjEdotQz897Jr5sr?=
 =?us-ascii?Q?hOA2mD9UGV0TKI+Y1kuJeib/EC8RKXH/bGObo83UtBUf9AdiVpYcj6sXs6hc?=
 =?us-ascii?Q?sAMo9H0eHXSqDyRNrrK8qN5J6lFtkjwWSWeHNT+5TpHAaSzAr9Z2H6bPWAV2?=
 =?us-ascii?Q?QerKcBLYJ5LtHwXa9GQEREJ+kyPavhU24YL3lxRtfsauxgpHmhJCu+n39tTs?=
 =?us-ascii?Q?2z7SmkQ4wN9+GED7mNi+12cr+3fEOtjkFyKj63Ydia2js5ltNKSKZ1sibFC8?=
 =?us-ascii?Q?sfmtN6sM7bFhEVUCUHmAyt87nDEUeNO8YNblE3e109GmjwZUjS04yBGt3uU5?=
 =?us-ascii?Q?LquDf8FQAwd2IeCLa2Kcs6Og+HAInZbH/2Ki6lPoykfR5vUH4U2RssN8myyh?=
 =?us-ascii?Q?fSkmQdP6EL6oxZhaxfg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcca35a-5fca-467e-c626-08de05b38435
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 15:09:30.8128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nph+4JfG570DDkLfqimABQkDl7823kL2gR2zO/H/tO9yO9ulU7L1WGBuIosYxvWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6062
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

[Public]

Series is
        Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Tuesday, October 7, 2025 7:05 PM
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH v3 0/5] Adjustment to power limit setting

Lijo pointed out to me that
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume") c=
ommit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during r=
esume")

both should be unnecessary because smu_restore_dpm_user_profile() already r=
estores them.  However in looking at the code there is a case that isn't pr=
operly restored - the FAST PPT limits supported by Van Gogh. The nuance isn=
't immediately obvious because the limit variable is overloaded with limit =
type.

This series attempts to address that issue by passing limit type around and=
 saving/restoring both types.

Cc: Lijo Lazar <Lijo.Lazar@amd.com>

Mario Limonciello (5):
  drm/amd: Remove some unncessary header includes
  drm/amd: Stop overloading power limit with limit type
  drm/amd: Save and restore all limit types
  drm/amd: Drop calls to restore power limit and clock from smu_resume()
  drm/amd: Adjust whitespace for vangogh_ppt

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  5 +--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 40 ++++++++-----------
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 +-  .../gpu/drm/amd/pm/=
swsmu/smu11/vangogh_ppt.c  | 13 +++---
 8 files changed, 29 insertions(+), 42 deletions(-)

--
2.51.0

