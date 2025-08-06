Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA1C87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 14:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E4610E77F;
	Wed,  6 Aug 2025 14:09:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lho5AP8t";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3BC10E080
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 14:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmM5V06MpWzayyV4tfit8LA/IqY2TsV3ZE4CCYs6pUzWDYs/6e+NcQ1djNqTvaef/KT6+7sM4T5NXd7r8BuH8BFcr0PZ9J8rHHHS6SC+0zgbGwA/joU+r6TljxsLpgtkfTNhfg6epcvIUHfcYsIAysqKxNBf2tYERcu/WpQhstfkt7dWxu/6cmt0rQomZlvreS81gO6Q7AvA4rkfECBrGa1vV81jRrMac8hcqIUtsNSC30pX4a+PKczIPZ17c6EJo2kHVOMu502Vx32oecbcERomXjHXAq8C6flRc0rq64yMcuwO+JpL4pvZ04uh1cqu6taR/E8SQhPU9O4GJ2upaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/GXQzBlrjLADzdDviE2CojsutpYByt66pwA+DaPdzM=;
 b=OejgIeLGEi9x6dEjph15FF8ge1GZ63fZhOQp5cEr2qMaPR9ak9g1eRw4c9ONpX1nGt+n1a/iTrXoNU4OWPrgkbo6ZBqcw83Q6Usz365ckKPwSJqMGLM+PpFm7JTp/Psv/bkxGR2YTpFbaSNR72zacJSlnlDSyn2X+05bJZdTikTEZ7glkdWpC8w/X/y2viFL5oiia0UURkMEb8aa/O26xQpk6/bXZtgWTZUeE1AvAMBVB9qeSYbUlmvghAwV57bW0WMjEqzvbCf6l1fccQxoTKCUJFMpP6BtPI6pkuEWd+GTg+P4sYBSk38taGdWNAuPgMu7GAAp07ur9vIC5WSVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/GXQzBlrjLADzdDviE2CojsutpYByt66pwA+DaPdzM=;
 b=Lho5AP8tGy9Eb5eIISDve0gCb2jPuHQfYY/a9yQp6azd/JEDbS5K9h3I/3bSD7BSZ1FADzr9jYiD8pDU5sLBPOuy71gB88RYDZHipQJUG0sL+MreE6r4XXmFd0ZLYEXz0XQ9Sczo9Ol8cJs7d+4cnBzoCFvfNhKkuj2WwSXexww=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 14:09:33 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 14:09:32 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, "Li, Roman" <Roman.Li@amd.com>, "Chung, 
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>, "Wheeler, Daniel"
 <Daniel.Wheeler@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add NULL check for stream before
 dereference in 'dm_vupdate_high_irq'
Thread-Topic: [PATCH] drm/amd/display: Add NULL check for stream before
 dereference in 'dm_vupdate_high_irq'
Thread-Index: AQHcBtD4ZhgePigNt0yjyF8fu2YGMrRVqbIR
Date: Wed, 6 Aug 2025 14:09:32 +0000
Message-ID: <CH0PR12MB5284089EF7CA43DC4B232B9F8B2DA@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250806125155.3615401-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250806125155.3615401-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T14:09:30.894Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|CY5PR12MB6132:EE_
x-ms-office365-filtering-correlation-id: 5ccc7ad5-dddb-4d82-cb77-08ddd4f2ddf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lidCidCwhe+pevYbu7wDV+8/dwgU4cHrV4pYE8PrtJad4kbnZvlV48wO7uJG?=
 =?us-ascii?Q?p/fgBEnsLpha6mSqnHsLzgMIIJAVmyI3wpc4MIAAYPMzFz82PEmGSis2NUKY?=
 =?us-ascii?Q?Eg4kyuIUn8mVn2uWf1yRnk6ybdKzsOADvrfRFInW1gJo8O5GyuUbLstC3u4i?=
 =?us-ascii?Q?iu6g3MFGUf0bzxfSYEb0jl9iLs6uCuuxWm+XvnxC7ieb29kxeQR0TEJy3Bol?=
 =?us-ascii?Q?o5uWgdgmlEtha7qMU2gPxRBNz7qYw3lz3Z1JtOp8uu5E126pAJfs9cN2sSES?=
 =?us-ascii?Q?yUGkOjKesTjvHvjQXYE1kfYT+y5Vqytk2yAqhI06EcNRHRZ/cHnFmfsdsZYt?=
 =?us-ascii?Q?a2wFfWWXotdMwbdPipYm2HiEMJ4ofCkp7KEJCeg+1nn8m/uQsTUCRgPlop62?=
 =?us-ascii?Q?lAejx20XCQtXNZyiu64GAeQ5psa2xsdDb2MWiWob5SLFxS9NXqMcI33Cfna+?=
 =?us-ascii?Q?mTXNOvr078QKnIYmOoA4vt8AoMoP5IPwDw9w1TWpNgfJfak8+bVm3C72bcTn?=
 =?us-ascii?Q?9X6o/sfMJ1uY9b+hA+umF8L4zdU3TKm9RIF61FFaFmVgKnN8h5vZGQSs4StT?=
 =?us-ascii?Q?sSaYJMhylqB1amOStbOOngC5bqkHm75k7fBjW9YhxTavLfETl7efWa1sIVcJ?=
 =?us-ascii?Q?ue0B3q+DoC+pNM93ZHmZcAr/0AlvdNtxArQ0WIeoIOXEqqfaHECGAjn3jHlE?=
 =?us-ascii?Q?ldBL4LnXMteWmUVP10//spFkj/+HeYnZXT/Rc92hTRboPU5EwHeIl1GLcuS7?=
 =?us-ascii?Q?3/itinRZwhYErfgk2GWKTAqbRPxqq0oWKokMDlf36fC99Rcj7bLawvP7Nqtn?=
 =?us-ascii?Q?/gRpuM5o2tCT6TRXp4Y9B12IbtKooEW+DMBWrap2IbTmwBnLhghyEYPqTH+t?=
 =?us-ascii?Q?iKi/xVQnGmg3ay01WPJ/6VcrlHI9r/pyTR5OrxnEQo86sbJnzTRU5QEu93s+?=
 =?us-ascii?Q?KWv+F03EBhD68glCcOUcfVKMCMmlz8NR8HAP6BBdLuizI5hofUxjfnCkRuoV?=
 =?us-ascii?Q?0jZPxLvCeXS9U/gC0q4HQnlc4Hcg61GybLlhJJM+P1lv/tYZD6fZzZBZJ4PM?=
 =?us-ascii?Q?+8BEy27PuFdf/DGUpLNSP+Y1dWnpF2hOBK39LezG/itqRDT2qtip++6z8uMA?=
 =?us-ascii?Q?5FwUyHn6FmOFicNMYXA4NwLgGXUgYMGRfz5PCwEcz6GQgEjjoKcHqC7gXLOW?=
 =?us-ascii?Q?Cf+dQor4vBHjf0p7N5wBLibFEJ9BHI+Pz4yL6MaQsUkoi4BGNe/5GVrqbpdb?=
 =?us-ascii?Q?TOrrsH6hur1ZQULud1tGBlJXKk9rF4DIawUGUlrce6JbaluFerzdjl5Asqpd?=
 =?us-ascii?Q?4VOF023FIfThhg/bzpvGCjzfKbd+TjzC2oHdpmrL809L8GteAZ1ouIpY5MmR?=
 =?us-ascii?Q?KKHlyWtLjfO6+mYpwLj8Bb9NcxiFBQIr08Jgx/7I9hLcC5vm6iWRHeMuHjm4?=
 =?us-ascii?Q?fzHGDIky1e1jekVj6Xbcb5sbsM5TzTmtqnaQL2FIOZlr2okBuZLsiXvxKSov?=
 =?us-ascii?Q?PnxxbyAFT1UoCv8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kp4bGY02/EzBBnoHhEJWrqblAchWLnKEl7iUwGTcquLGgB9EdOTdpf9keyEY?=
 =?us-ascii?Q?UhRfymi1IpgEm1EytEfc7g2WpBvatduS+O805TuEjmAP6BFYDJT4a+5r+UN+?=
 =?us-ascii?Q?U/hYqe0+z3LMbxl16QDMGOYzJplwt7snoKHzz/ZkeOA2pr6QG8eewaMJOE+h?=
 =?us-ascii?Q?ptY3sDGC68LNJxOkCSLvrkNNzfbQwQg0PXeAw5TktPB9GGQ7k0i70CHEgXFP?=
 =?us-ascii?Q?73/rl6hJCjyNDgqBRXQ1B1ezyFgLvNXBL/qf5akh87U3P14IJJhMW0E6VpHY?=
 =?us-ascii?Q?aYvSp9MWCkphbLMkCfes0qWu6zRBV6tkAaJiDX3lSCIBRM5T3zUN4QgZLMfp?=
 =?us-ascii?Q?IVGkLFLUqzImSZgAY8wXAPuaevzpXHWFYbSh5dKAvgApZN19bN87a1apIRHu?=
 =?us-ascii?Q?k0b0LsKaXZlL+P08P3EL1tUqwIuy+kMv/uXkhz+ulEDDQdBD5S61J97B2WVS?=
 =?us-ascii?Q?IbRbgohdwa1irNw1UnsT5xeRkWSBq3yEp1Pc1x6szCXbjPfzZQPA7mzD33zE?=
 =?us-ascii?Q?rxTTx07rv4jbF7XAjjm8ArFp+H986eY12UFyIcMRQE+PkNWluTizckWrdN41?=
 =?us-ascii?Q?Zm0dDvDdfg7bUmDHfKtNLim74bqkNxZVGye2UbMgcYpodi0Gbt/dlVTR/BTz?=
 =?us-ascii?Q?xSD2gRsCwXTL/WyjftTxpO8tQraK/DBZcLKNBEsx9/HESVE879BNd+jfV1fD?=
 =?us-ascii?Q?nTfUUeS4uU/XjzapLaS5mihmhl/o2YyDihKJc4bfB7m5ZTqnHzJddCnHnyob?=
 =?us-ascii?Q?+UGWfHJw8TM0kCmqcA7Apuep4QFpH7tcQ47JYptFh9dI87YehO58icG5zn9y?=
 =?us-ascii?Q?LqNALTAWQcEeoNynvCRyx58Af2x1+bG55ju6oJ2shbVWk8+jkIQq6JjqIrMy?=
 =?us-ascii?Q?bkfGJhWBFZh+gatVyEfIspk+17OMb3BhknkRvIUXv+9WzJFHveEtvYVSAuWB?=
 =?us-ascii?Q?YR2IfGK8RuKh/z3YlAl9Yd44R/iipacsXvuofGDzp/tWATYRTzVtOmnt0pBA?=
 =?us-ascii?Q?dlbV3cGucRCQGlAtWk5/cyeIBlrTlh4oz7Ultri5LzQAPQRn/7lLK7KOpyT1?=
 =?us-ascii?Q?3XdM/l62oP9YmfvNTdMr5braOswH7U8H/JsBlnKodXbQNE65VXSsPzAvH+h0?=
 =?us-ascii?Q?zLZhQSdx0t1RUtM+GSydePT76uwPJl9fKOTPvlc+o3CAHJvzxo7Nr3UpJq1E?=
 =?us-ascii?Q?qFXvJ6OID4oACj5D9ADi1Bm0C/CdxfptgTA+zlHcmmv4b2K9+vEuc0VWGs9n?=
 =?us-ascii?Q?FY7c8NraQfFf3j7Od+MjjGFx3xv9BJU5lb25Ypc+WDw9Em6/baEePnU2VSYc?=
 =?us-ascii?Q?gQWsHtLhNS4nerfBbj8GAxz+eodqXvBGyZQLZ+rshWa12uz0pLIpQwKR1tt/?=
 =?us-ascii?Q?/o2s99ntuqSBEwUeArs3Vo3kfWUC4K/5Yk5oppMGUQQKALhCP7aX/xxiJ38W?=
 =?us-ascii?Q?v8sYpNHhvahFbK8ZYb/yIhfUj81XnqreASeGOmg7VYn5EPTdUKtIXVuMsLZ5?=
 =?us-ascii?Q?a1mVnK2E7REq+A8D7OHFgr0B/7GCJSTsQPQTBHqCqNXc5Fes3Kk73XCNTFbI?=
 =?us-ascii?Q?aZkPPzB5k5DauL0QsBI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284089EF7CA43DC4B232B9F8B2DACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccc7ad5-dddb-4d82-cb77-08ddd4f2ddf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 14:09:32.7448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHkBR1/TafCbfyW5wxyVkXXueZLrbvowYz/Sjl2GSxYfA69QOK6eDPs4rSRMkv9MGnxZ4c9DhDAvrzcwblWoDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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

--_000_CH0PR12MB5284089EF7CA43DC4B232B9F8B2DACH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay


________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Wednesday, August 6, 2025 8:51 AM
To: Hung, Alex <Alex.Hung@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd=
.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; SHANMUGA=
M, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Dan Carpenter <dan.carpenter@=
linaro.org>; Li, Roman <Roman.Li@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsua=
n.Chung@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Wu, Ray <Ray.Wu=
@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Kazlauskas, Nicholas <=
Nicholas.Kazlauskas@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for stream before derefere=
nce in 'dm_vupdate_high_irq'

Add a NULL check for acrtc->dm_irq_params.stream before
accessing its members.

Fixes below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:623
dm_vupdate_high_irq() warn: variable dereferenced before check
'acrtc->dm_irq_params.stream' (see line 615)

614     if (vrr_active) {
615             bool replay_en =3D acrtc->dm_irq_params.stream->link->repla=
y_settings.replay_feature_enabled;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
616             bool psr_en =3D acrtc->dm_irq_params.stream->link->psr_sett=
ings.psr_feature_enabled;
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^ New dereferences

617             bool fs_active_var_en =3D acrtc->dm_irq_params.freesync_con=
fig.state
618                     =3D=3D VRR_STATE_ACTIVE_VARIABLE;
619
620             amdgpu_dm_crtc_handle_vblank(acrtc);
621
622             /* BTR processing for pre-DCE12 ASICs */
623             if (acrtc->dm_irq_params.stream &&
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^ But the existing code assum=
ed it could be NULL. Someone is wrong.

624                 adev->family < AMDGPU_FAMILY_AI) {
625                     spin_lock_irqsave(&adev_to_drm(adev)->event_lock, f=
lags);

'Fixes: 7a586ce03c42 ("drm/amd/display: more liberal vmin/vmax update for f=
reesync")'
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 31ea57edeb45..c0d31c26850d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -611,7 +611,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
                  * page-flip completion events that have been queued to us
                  * if a pageflip happened inside front-porch.
                  */
-               if (vrr_active) {
+               if (vrr_active && acrtc->dm_irq_params.stream) {
                         bool replay_en =3D acrtc->dm_irq_params.stream->li=
nk->replay_settings.replay_feature_enabled;
                         bool psr_en =3D acrtc->dm_irq_params.stream->link-=
>psr_settings.psr_feature_enabled;
                         bool fs_active_var_en =3D acrtc->dm_irq_params.fre=
esync_config.state
@@ -620,8 +620,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
                         amdgpu_dm_crtc_handle_vblank(acrtc);

                         /* BTR processing for pre-DCE12 ASICs */
-                       if (acrtc->dm_irq_params.stream &&
-                           adev->family < AMDGPU_FAMILY_AI) {
+                       if (adev->family < AMDGPU_FAMILY_AI) {
                                 spin_lock_irqsave(&adev_to_drm(adev)->even=
t_lock, flags);
                                 mod_freesync_handle_v_update(
                                     adev->dm.freesync_module,
--
2.34.1


--_000_CH0PR12MB5284089EF7CA43DC4B232B9F8B2DACH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 10pt; color: rgb(0, 0, 255);" cl=
ass=3D"elementToProof">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 6, 2025 8:51 AM<br>
<b>To:</b> Hung, Alex &lt;Alex.Hung@amd.com&gt;; Pillai, Aurabindo &lt;Aura=
bindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; SHANMUGAM, SRINIVASAN &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;; Dan Carpen=
ter &lt;dan.carpenter@linaro.org&gt;; Li, Roman &lt;Roman.Li@amd.com&gt;; C=
hung, ChiaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;; Wentland,
 Harry &lt;Harry.Wentland@amd.com&gt;; Wu, Ray &lt;Ray.Wu@amd.com&gt;; Whee=
ler, Daniel &lt;Daniel.Wheeler@amd.com&gt;; Kazlauskas, Nicholas &lt;Nichol=
as.Kazlauskas@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Add NULL check for stream before d=
ereference in 'dm_vupdate_high_irq'</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add a NULL check for acrtc-&gt;dm_irq_params.strea=
m before<br>
accessing its members.<br>
<br>
Fixes below:<br>
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:623<br>
dm_vupdate_high_irq() warn: variable dereferenced before check<br>
'acrtc-&gt;dm_irq_params.stream' (see line 615)<br>
<br>
614&nbsp;&nbsp;&nbsp;&nbsp; if (vrr_active) {<br>
615&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bool replay_en =3D acrtc-&gt;dm_irq_params.stream-&gt;link-&gt;replay_sett=
ings.replay_feature_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
616&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bool psr_en =3D acrtc-&gt;dm_irq_params.stream-&gt;link-&gt;psr_settings.p=
sr_feature_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^^^^^^^^^^ New dereferences<br>
<br>
617&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 bool fs_active_var_en =3D acrtc-&gt;dm_irq_params.freesync_config.state<br=
>
618&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D VRR_STATE_ACTIVE_VA=
RIABLE;<br>
619<br>
620&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 amdgpu_dm_crtc_handle_vblank(acrtc);<br>
621<br>
622&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* BTR processing for pre-DCE12 ASICs */<br>
623&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 if (acrtc-&gt;dm_irq_params.stream &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^^^^^^^^^^^^^^ But the=
 existing code assumed it could be NULL. Someone is wrong.<br>
<br>
624&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;family &lt; AMDGPU_FAMILY_AI) {<br>
625&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;ade=
v_to_drm(adev)-&gt;event_lock, flags);<br>
<br>
'Fixes: 7a586ce03c42 (&quot;drm/amd/display: more liberal vmin/vmax update =
for freesync&quot;)'<br>
Reported-by: Dan Carpenter &lt;dan.carpenter@linaro.org&gt;<br>
Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Cc: Roman Li &lt;roman.li@amd.com&gt;<br>
Cc: ChiaHsuan Chung &lt;chiahsuan.chung@amd.com&gt;<br>
Cc: Harry Wentland &lt;harry.wentland@amd.com&gt;<br>
Cc: Ray Wu &lt;ray.wu@amd.com&gt;<br>
Cc: Daniel Wheeler &lt;daniel.wheeler@amd.com&gt;<br>
Cc: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&gt;<br=
>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---<br>
&nbsp;1 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 31ea57edeb45..c0d31c26850d 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -611,7 +611,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * page-flip completion events that have been qu=
eued to us<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * if a pageflip happened inside front-porch.<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vrr_active) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vrr_active &amp;&amp; acrtc-&gt;dm_irq_params.stream) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
replay_en =3D acrtc-&gt;dm_irq_params.stream-&gt;link-&gt;replay_settings.r=
eplay_feature_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
psr_en =3D acrtc-&gt;dm_irq_params.stream-&gt;link-&gt;psr_settings.psr_fea=
ture_enabled;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool =
fs_active_var_en =3D acrtc-&gt;dm_irq_params.freesync_config.state<br>
@@ -620,8 +620,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_dm_crtc_handle_vblank(acrtc);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BT=
R processing for pre-DCE12 ASICs */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acrtc-&gt;dm=
_irq_params.stream &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;family &lt; AMDGPU_FAMILY_AI) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;fam=
ily &lt; AMDGPU_FAMILY_AI) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev_to_d=
rm(adev)-&gt;event_lock, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mod_freesync_handle_v_update(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;dm.freesync_module,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB5284089EF7CA43DC4B232B9F8B2DACH0PR12MB5284namp_--
