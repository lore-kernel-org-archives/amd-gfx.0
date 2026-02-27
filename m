Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7380DFD9E2E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 02:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC0410EA21;
	Fri, 27 Feb 2026 02:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3t9cfvTr";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011004.outbound.protection.outlook.com [52.101.62.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F2B10EA21
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 02:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4YJwFzSjaWY20QTGC6qn0vQTG36vEOVCBUkl0+q1FRvqDxgcvs+Lf9CyM99mp+qXCh1A6Yg3Az6V4IgCnRofHg1r3/VteQZ+s8Ss4NzAE+rg2RQVp6Fk39t2Y7hhwMTy9JJ9wkZpwVteKxApgYIC2fi3+n7TxJW3W1+O1ud40tO6wqurWnNjrf+pfVpdN7osLCZ11GYDqcji49xP5kHVcf9IPx3aLX0UCwCJ9pakiRqghnf1kwpJZRGc36jcUvq9qvdrO0xDIpQoMrxFP39CrMAwu3V2V3LpHwWrHpwUeXTpFLOLZOEN8u+x1Von4Z4bZUzrAIpi2tBZIX201Wqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XFUYYM4z2UfRkPPRP5tT9rMsY2Rpg0Q2Uy6XlZbit8=;
 b=Q+Qo6D/TVoaRsRvyAhvPqytLjdNoOwMO/0i1vjsYnjfdnyA9OccfxiUAM3rO9z6XfN1GERDc3Japg4zpoIdMQ1GWO2sEtagZTYOE0u4KfKJHCvo9x2n6nKMN90QXcuzXFEy+g/8VIH4lm2u0btydMXbOsVRb64hJ0UC2E5tApbkrc9ZyrrLt+Z5EWPfDxgHXpVbHwF7QMe3/fSS8vUBNiL/ddfvAyAb7Vfh74uEVdpf93jTrtZfRlpnzJ+WlT9ukXvMNNn4m+RzaofWGejvfOHS/sCLG/PDLFnrRWw4iw0LkV6Urws0bEgpHhvECUI7mBPu3cwZLcZirqn7Q7iIgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XFUYYM4z2UfRkPPRP5tT9rMsY2Rpg0Q2Uy6XlZbit8=;
 b=3t9cfvTrJDzk597FOV3kWpCkUoiTUK6iRkRxNI4C5tM1uESg7NOQ5UK9Sa2evSb6WUZnS9OtuCST6y7B6qMGkOyo3OrYagyxvFv3qX+2bGG7sun0sdNQPdioAFK+wFajIZOf6YPrgTVEdmXQdJ1z0UW9tH9O379vKafb7C1GdhY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 02:56:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 02:56:11 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: clear related counter after RAS eeprom
 reset
Thread-Topic: [PATCH 2/2] drm/amdgpu: clear related counter after RAS eeprom
 reset
Thread-Index: AQHcpvfDMnDZNyGe3Ee7+F08ftQxdbWV2ztw
Date: Fri, 27 Feb 2026 02:56:10 +0000
Message-ID: <BN9PR12MB52570BE6788705537CAEABD1FC73A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260226081246.465526-1-tao.zhou1@amd.com>
 <20260226081246.465526-2-tao.zhou1@amd.com>
In-Reply-To: <20260226081246.465526-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-27T02:55:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|IA1PR12MB7733:EE_
x-ms-office365-filtering-correlation-id: 34f8e837-08f1-40b2-fdd9-08de75abc34f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: L7xfm5rtRAvG4r5SNNaJL0SbwK5wN6AL+g15jwp/0TOLZII7FpEQ1YTuI4Rhk465fEinAwR5XRIUlnKQQxcMLRStFDhw+W0qGLYlbSlJyiKJUEiaBxrwlHwTr7lNHwq0MID4phtBwV+eZQnDE8JzDZjYz4hs8U03ShnD6r8BGqcEfJxtjYquasvo2bqLGHAPsxrCn9JLWsmfOrg29mEzBNWm8Pums8WiFNcz+OupNLe8A9oYdBBvk8DqcJMS/+u9nNW6FZxc3TyF0JWUUZldfrlXZ1rAQ7lIDhRju9Hmms17tfMIh/DbCRArXereEE6P2wXkdK0+XI0SaPJSEfhS1ei0q4GeI+tFXMADjhUe3XmGYxAv7LcGNH5fVZrIO1phMGfa0hwXGcmZ+VVkxHQ0DuaQzQrOZFILRwMKqD3XchldEHOuQzYs9Dd1YvIui39HeJewivzjr9EsnqF2lTfCUqg4E13fANyN+4hkql555davhTMM/TdKltAMFnUnIUcgSNFYzSCzjoz8ZrVup/5L3aoh6i1YDYyuuPPR8YpNZdJTiZHvPuwg0iYIXJHI5lzC8C8q8ljfIRylTuG1a3Xw/byNwX93YtqmRw3NVu6vBz9MU69/3chgOWuWKsz2qgOLrOjrvaI4lzb+l7oqwVMInbwKxN0aXd5wwR/sW//l6oNXN1gweka2HFiB1w+luCDCq7Bm7mHw/AsoNioMnq+ekl697R2H9Pr+dyw3hfEpiXu4ZQpsM+gzXTuAN3tcdvDgI5loBeGMt1AgpY5HXz/qNimnjboeNeTrFvTc5MJalQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6bXpZF4l+E7CJIGCD5mUA55W3s5nNC2ZIZhKmIDGJN0bQ/kTpO/4ctTCHcw+?=
 =?us-ascii?Q?Yecg8M8DwLTB2bxABgUqwDWG0rNQ0GG7AZZGY5h/KnBg56TQHWGubIZVfh+0?=
 =?us-ascii?Q?dB3OM7E1uOL3uqEPIVRBGyGkgPa2pWqiI1Thlb+qL6VYM2FSfTlhE3unebZc?=
 =?us-ascii?Q?20kg5YPj5wVzponlsTD5A371nH0q1xOt0FxR+4Ss5qv67CNANM92unpgTtsf?=
 =?us-ascii?Q?dXEXh1fHSxuHQ5BzvZm6tpeKSYKlyiBzMFXfeTlzwJODnlfjTBzpguVRaE96?=
 =?us-ascii?Q?iUL0morP49ofjj2E6I5iCFRfxYLeOjxhpHFVWgkp72asvCjNC34r4rGowySm?=
 =?us-ascii?Q?0CUtK3OGkWC+AbGavEpZUAUZyD1wvOWu+XpklNBfE3fXXIa8uJAbU1y7eBtJ?=
 =?us-ascii?Q?wmOXIyrFsXN8UYlGl+cIsTBWAM1A7mUd7LKDfSQWnibsqxulgk7IT7Y1Xxe3?=
 =?us-ascii?Q?wkibb9Pbdoyr7cc0FFBDf13qBMXouRoIqUQ3MXP1M2ul6RmNnxCJ3WsQSZL7?=
 =?us-ascii?Q?6+pdx1lmjTvFwM0nOQYMMA23EzuOTLy+ehsKPDj6M/QJxwc+H7HqH4n9ty6K?=
 =?us-ascii?Q?o+BjDbkc12VmBavecSpjY4ZjK0dT4AtT/jZUkeM6wTdPXBpz3tzONNwoiJQ2?=
 =?us-ascii?Q?aN5xU/H6eYll62sAdj0YVfpu4D8LmDPFon9JutBYcMMMwDnj8S/EE/Db/BSV?=
 =?us-ascii?Q?3PP2iA0lH/Xk08DrvSBULw3vpJ6/smmLW45wX0t7cJMXo/xriX4AHs9G/gho?=
 =?us-ascii?Q?2dhhCLo+bbyZFDAzFbMNbqPExoC/X0vtxSJIyHFRF0sFNkdMZBYVIcOuiYv6?=
 =?us-ascii?Q?ViELBte2lR/Ob8AHpVUoiP0B7qUW5+Q9AxyYJqw33sSCfhgfwFUQ+HsAbDeE?=
 =?us-ascii?Q?rkDfNeUaE0bey+LLlV5WxVgVVxtVCXBHcn7PEl+tPzsCQKAWcTPbLoZ2ZaG/?=
 =?us-ascii?Q?Iv9i3RPHyJAl+OaGkOzDgZrBlJUsxXhZ7yhFptuEyitUiyY8C2z47nO+YunD?=
 =?us-ascii?Q?utrcHki1Np156GBo6kJksTnzxS+wr8JqfzICsK6xS/w6E3X7eLjr+dawp4iX?=
 =?us-ascii?Q?VOj6vQJj/IYlROWyzU0Io5XWYpl0IOVpb5SvNsoslgXmK9ePm89DlSEprEax?=
 =?us-ascii?Q?z7NpsSC57ENHoS7dEv83iMWKP7TbDAdiUHot6ccjy86zTUoqStPR17xoG5Fm?=
 =?us-ascii?Q?RHbt7GGIINEixiXbO3PXiK43KgD0YrS3M8YSfq2fsO5EAdSLmFvWCBFebp1O?=
 =?us-ascii?Q?PL/cUnBL46cBkgfn/4RCWYJOfy+LM8SdMJ5CKXdTq7K5fDwRCOj7JQ47xD1A?=
 =?us-ascii?Q?3/bq569JFJyFbewV2LESz2uBnchOFfK3LBE2WcV/lcRuw1mUpFecwW5dNdLh?=
 =?us-ascii?Q?086CV2rQJk/Y2k0Mci1CmIgHgaUBtsavToMvuTxh1rqR44DWv5ah4mRqRNg1?=
 =?us-ascii?Q?vvZGTsRevbgx/YssZoGKHx6UmFXl2QL2HLwrcGuclKKKwYeVAqhJoWlE88d9?=
 =?us-ascii?Q?W2YFd5KoLQcipSRM23g1o20J/XsJ4kTiUgWc4En3H0NcqwE27JHgaAcWR6EH?=
 =?us-ascii?Q?sqYZnLNff6vNDcqYYPP2A6w5eIoEXFJS9mZKWGvnMt04dTxYrBPKTrFkfYzL?=
 =?us-ascii?Q?5jgGRjJZ0t/Uqf3NABmg3lZwZ+WGeBmvR8RM45GFokzaq44m/NJE8EIlfM9Z?=
 =?us-ascii?Q?H+FkItmBuqpooZAhsJIo8OWtYrvyhl7/T8j7f9+pOdJvR9ts?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f8e837-08f1-40b2-fdd9-08de75abc34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 02:56:10.9715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2Im6jCPDRsPGzwEquQwZuP97ymc8CXVU3KzBJiaKY7m2XBf4Kg/eChnQaWAn+Te2CrYg64FEEIF6npEZyZ6mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Thursday, February 26, 2026 16:13
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: clear related counter after RAS eeprom res=
et

Make eeprom data and its counter consistent.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 6fba9d5b29ea..44fba4b6aa92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -508,6 +508,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eep=
rom_control *control)
        control->bad_channel_bitmap =3D 0;
        amdgpu_dpm_send_hbm_bad_channel_flag(adev, control->bad_channel_bit=
map);
        con->update_channel_flag =3D false;
+       /* there is no record on eeprom now, clear the counter */
+       if (con->eh_data)
+               con->eh_data->count_saved =3D 0;

        amdgpu_ras_debugfs_set_ret_size(control);

--
2.34.1

