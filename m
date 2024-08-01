Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769D9C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED6D10E8AD;
	Thu,  1 Aug 2024 07:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Hi9x6iB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53A1210E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoS+1ytUNgI0pvXkHgvs3StQrvPvRZDdpFNTYaaCfIW2oWth08gBr8vJKlnke9oq5FJLO7ZJPx1SrAFgeZtrTQcOT+aEDhFjON1lRIer3z0Ag0wmm5Zdy+bfbv9YdIr4dPhuSsRME5QLHx9a/5QznHH4Hm6Y9y+h8OBEXDemzt/AzTMvJzRYQWX0f1JntH1VFsI1XTUPqIHFKV8Di2jJuwz+Ye9qX6jnSNz03dKjM5IQqKG7t7mrRUW6/EyD2wUC2x1iG3T8CaaP2T0218kf7MRHzfkw0xpl3wxqnmwq45rWiKRn1uA/NhzRYKetPvbZZZ4SXWdnBgGZ1wQhfNqLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaLzlIQnYgOnwSWYxJXFIJcHV/sHMvEJCc6FPzUtyRI=;
 b=wijL/vA4uBsfpQXFFRXL4fP0ifWISLWnTtvMepWeqep7DFzEBT0w6JRlJhX9OypBaVDZKcPPP6R4q6+mb2j6pM0jPdcbL4uM5Y2qyjhKSy7so3xEock7YerZXchRIfW3v5L/cuEIgSw0GGvHgxslztlqyog98JR3tEs057U+M7abnhRaZnopq/0iASIc1H2uJx189Af4JFFnhuMP1yQwyvbwn3S+74k5Vsd3RULJqDbuxo6I61ADfNjbosoHW5IM9ql/WfNmLV98mL67B6+IS9O63DdydYt7bVIS5nRBkdoK60FpW/p7izEjnOxiuiqkEEGLldsEy/U/RyXBH/KKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaLzlIQnYgOnwSWYxJXFIJcHV/sHMvEJCc6FPzUtyRI=;
 b=5Hi9x6iBX1++IzW7UHv96oKjcp0L83sItOs+FSpg31OHWD3DGOqJC8gjurLZu53qhLILYBHOY59ECd1Ojxo4xv3WfSSDa8DjdgfWL6i+1mNHBb7qB0Njl4UpSfH4bqBVFHNikrZ1LQfH8tVA5LcqGgNMf1Lh7FDCkG0VQ4pb0/0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 07:50:04 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 07:50:04 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Topic: [PATCH] drm/amdgpu: report bad status in GPU recovery
Thread-Index: AQHa4zE2Tg0CpIi6WkOtohax/K0s67IRtyqggAAOAwCAABioQIAAC24AgAAdraA=
Date: Thu, 1 Aug 2024 07:50:04 +0000
Message-ID: <BN9PR12MB5257F9DCB48D0CE2E8883349FCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240731100526.32903-1-tao.zhou1@amd.com>
 <BN9PR12MB5257A5C7FA776D10A6FD540FFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB87963EAAD611DFBE5AB79AC1B0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
 <BN9PR12MB52570AEF77D511EE5B2900FBFCB22@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB8796D2E81A39D402B2871EDAB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796D2E81A39D402B2871EDAB0B22@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=60b2d777-4128-49f9-8b5b-a6aaa5eae599;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-01T02:59:07Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8075:EE_
x-ms-office365-filtering-correlation-id: 9256afd7-8ffa-4a85-b9fd-08dcb1fe8e15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3iEk2ARZJFJWzjlRj8z704o84wq35oGMtgHfmZ/ioanxfqPcofB3+bdqAV9M?=
 =?us-ascii?Q?2RWGDgGBD++x+NfDQKiFKStkvo7DQdtq0gezN//fGzV4O296T4C6x9PiBEVi?=
 =?us-ascii?Q?WW33bBq98PMYyKWyScGPGvYbVvB8r/FSx3ktIwLaBhd7WwDQOykqQeYkIAex?=
 =?us-ascii?Q?pErtLX0h3nDy40aC+dnST/Wspvh7Czdra3lfE1KSo1X4xpls4CLAMr43yagD?=
 =?us-ascii?Q?3DlRq4ve3cWENjBDgYeK14a0NH9iEKcwmWlS5uckazVy2bR0vOc3bJw4u9EL?=
 =?us-ascii?Q?ikTRpMbyjBE3WiiS7goOZDt1zikifBnF5CnaderyLWDEG1pBlDuaHYwO71+0?=
 =?us-ascii?Q?6C74fMhFbFeiwKRLDNmUpGvc9vPUBMxN5EpcUi6xClID55f1sofbTuX1Z4Gm?=
 =?us-ascii?Q?VftH7WuJVdcsoZKD4dDPHRRq8HzhHpgKTxqlfjdlAzRkYlKN/wZATFd0QjMW?=
 =?us-ascii?Q?cYJrrpa9OOQXe8qrDsG7b9bCud8sx5WV6jSlkGTL3JfKam3ULUfAY8j52sSP?=
 =?us-ascii?Q?whJ7nEkICaxv4gxbzqp1ftJNMOxSce3qgPLnpmWpnMjGTa4Ns3Xf5zI4ym8r?=
 =?us-ascii?Q?7AEJ2Fkz8EIVaJjeIB8Y1jrEZKdm7VpUsDCmcntFd8plgDVQvSYw04BcUNNw?=
 =?us-ascii?Q?TOgRwYTqye7eZ2Nxf8wciYEFCRz1yBws3Whxw1AD8TnEMd1cA6005GQlDZxY?=
 =?us-ascii?Q?jykVmSGBMvdWIbGWXrXQSLqWMXcRgbyKe8w+RILnQdPGs1PqegSJOLeq+wwb?=
 =?us-ascii?Q?zn13HHBloGRxlcOlsXLoG99L0U/cicbAp1EF9Q1uCQtJGVrzdNpxwCXZ6hfi?=
 =?us-ascii?Q?ALjIGu/3npvqi/OoOFsB1EInfkKt6Dcde4ZfoclhU5k0RNhvxbtnX5q7N062?=
 =?us-ascii?Q?wMKdD9uswShC+gdyvekp2n8kZmlPilBVTR/tilJNGiYlwCoxNVJGAGKRWMXR?=
 =?us-ascii?Q?r+KIYFMNF0aaNxBdExZRje4Zv3VksRM18d32HW9axrzAYQGpO1T5KLjZFDB8?=
 =?us-ascii?Q?wJoSyqIT0Zw3g1Xx0KDvECPvGCE570DNO7xBlWtSavsMfGTWVlJsCFbFWdL5?=
 =?us-ascii?Q?HCDvYvfYjbKWNo2mrRF887TxxMrzwPqqi+WcnpMjxLGMPw9Yw66pgEPKmB1M?=
 =?us-ascii?Q?AJAnVjXt/xXEJxhpOJykapIfU+B5n5EusKq+Y+eJNX0vok1+DCwky1v7GogD?=
 =?us-ascii?Q?gkdXkI40g7xdQM8OKpgL2wPaLbWNtniwiUtg9XbRBBNAz0TMDW8VvZmswjKV?=
 =?us-ascii?Q?0sn6Av0f0ziu6ah96ht7elGWi6ucuCAA9mlvnW+gGPheE5dK7TMFJ2DBbw1x?=
 =?us-ascii?Q?6DsMexcFlWMPHK/sjCtDzux5A6u63nk0MwU9PKUnZz1hK/G//zpPJof6vzvi?=
 =?us-ascii?Q?nezWVrPLV7fgIuH5v66GH/+YjKZW5CjckitoeCmdQ1kd78yqJg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nYbBckItK2qHR+92sApW/UypSlX5SYlsM7RLtPpGrHVQifMdd+j2qDIHrVPi?=
 =?us-ascii?Q?CB2TbUANwcBXr7Hx1OriYk0d51JkOq+l+APLtBd7FfFA94H3BxoQeTo7tEgb?=
 =?us-ascii?Q?CTNk16pnmC1mLPaz/ZTLC67hFv4g/PIPlusdn+93TnDOOzdVRW9eVIF5NPJ1?=
 =?us-ascii?Q?X0UgfVtR3hM8Gg/Znwlr63kR4cvfblYT4gzUXcmuHSEYdSXvSBU+PXR/fGUj?=
 =?us-ascii?Q?kN+KuIMPI+cltIUi2R7E9+K24hjt5uveVL6NIwjBSxg9FV1RfObkDzZxbibA?=
 =?us-ascii?Q?K4PasVUD4Xg4C5U+HaklaYD63FhQyI6qdlVKCHqdqb3pG50pdKE7Hl5B9h7b?=
 =?us-ascii?Q?wtR5X5ZruO0kt3w8cXvYcN/tWtgi0fyHpUPM3jz79f426rUzxxpis0hyLvs3?=
 =?us-ascii?Q?r6iMzsUaM+3FKwjLmKmWSH+My6BLjbfEHzxGYkCjurB8FAlPdxl1Up2AU+Xl?=
 =?us-ascii?Q?K0TZTg5rfOILM0omGNCmcPATEDozeEpWjjal1YDJpjVvLX1weAJ6Qi7m9oC3?=
 =?us-ascii?Q?psSdxpjNhgbHlKB5/yRis3ycKrBjZVPacDveJCGaLqSpB1qsTLHtuC5UNhIl?=
 =?us-ascii?Q?kqi6ZpopG04285WEjpXomntpQyTVJB6ExlFNCessuInF+j/KF0v8TVIt+ERi?=
 =?us-ascii?Q?uYooYncPSRp9pJfPnItPmu68CwU9WAI1NUa+K7y+BQ2kmXH7euPh3yWsOOxb?=
 =?us-ascii?Q?xXvbzPGEQLf0ixTxv7Pbfpy7cN+3Okw19aN9tYO1D1fy21bcFSoBjR+98IzR?=
 =?us-ascii?Q?RMAf4YjB9v2IV8KKaDaeFGy6p5OBp9uKn78bBxS2XSqi8AWEX1MxpqjP7QNn?=
 =?us-ascii?Q?L6oWv1eF9OEMXn5d6U/WTxXeghGcniwqUtN8KxBSE0ynMHJcgqgdY3r+C3uM?=
 =?us-ascii?Q?RtcopErPqYQCqWDNaXHl+gKsFjsiht3YSbkeOag6c6rlxkl5GtlTPCYxI5r7?=
 =?us-ascii?Q?JvjtzmP7wOfBQUuBYrbQFtXaglxKwYaG6YR5eFCmNWU69PWxFhj/tj/Fqq7H?=
 =?us-ascii?Q?fLhUWbpzz0HsiuOOJlJFcQKgGRmP/TkO8bReq6q6dUbrR3axMI6pYVsuyDQH?=
 =?us-ascii?Q?HHkz4bb+X55prSt/w5W1+TK30BvZ2BwczTiTocYS3NBsQYbz7NI3bwOgpDXv?=
 =?us-ascii?Q?jS1EN31xtL9k0n4cRtYgssEJOe3MUGIvqN2HFjE7RAdygeoBGCdbenHxG/E/?=
 =?us-ascii?Q?vYgvPn47L61JWl8fq4TE+IZaQ4Qz1uDv4FLL0YqvwwW4+rJNmL/c39hHI7sK?=
 =?us-ascii?Q?qVqQhs13samuFoN5vKeh3XOht5vnOlhHI9Eqv0lOIPK9m3S3zJPVMSMKkSdc?=
 =?us-ascii?Q?9daSR1bBd0ZnjEkPafQeJEHnjNXQCyXhVY6IZHfPm9+k+3s7FEizmFAYMWF+?=
 =?us-ascii?Q?ez/70bcN86Pl9aADm8jByYxsdfD0JfiVAgzejb55IvZtxJebAlOiGiggnDRj?=
 =?us-ascii?Q?eaxvzH1/IpKj8YxBgUzaQoRWkYf60ol62IpwHNxKs+u7zDraQY7voEdKPmif?=
 =?us-ascii?Q?NNdroqZMWOjE9aAtT3t+d2kAIyTYaWLqM0wOIajnvioAElDZxh6NezyKfPM4?=
 =?us-ascii?Q?1ACqZNxbYYV0taRIFz24le1zJ2GXM9b6aacNqiqJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9256afd7-8ffa-4a85-b9fd-08dcb1fe8e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 07:50:04.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /lqYoGUTcNoHC+X39gf7Kp0z+z3sF20hUMxs60BVx3qemErmoZfUsmS6bGQQH3XwxH3eVSrRNitqHTAxXc6eKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
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

How about replace amdgpu_ras_eeprom_check_err_threshold with ras->is_rma an=
d move amdgpu_ras_eeprom_check_err_threshold to end of gpu recovery as the =
change you made. In such case we don;'t need to add a paremter in the funct=
ion just to disable a few messages. And also the message will be the end of=
 gpu recovery as a reminder.

amdgpu_do_asic_reset
if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev)) {
/* must succeed. */
amdgpu_ras_resume(tmp_adev);
} else {
        r =3D -EINVAL;
        goto out;
}

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, August 1, 2024 13:58
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery

[AMD Official Use Only - AMD Internal Distribution Only]

Yes, the bad status message is printed twice with this patch. I think it's =
harmless and the second message is more convenient for customer.

I can add a parameter for amdgpu_ras_eeprom_check_err_threshold to disable =
the first message if you think printing message twice is not a good idea.

Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Thursday, August 1, 2024 1:30 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Right, it's functional. My concern is whether the kernel message in
> amdgpu_ras_eeprom_check_err_threshold will be printed twice. This is
> the end of gpu recovery (i.e., report gpu reset failed or gpu reset succe=
ed).
> Check_err_threshold was already done before reaching here.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, August 1, 2024 11:49
> To: Zhang, Hawking <Hawking.Zhang@amd.com>;
> amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> I think the if condition in amdgpu_ras_eeprom_check_err_threshold is
> good enough, no need to update it with is_rma.
>
> Tao
>
> > -----Original Message-----
> > From: Zhang, Hawking <Hawking.Zhang@amd.com>
> > Sent: Thursday, August 1, 2024 11:00 AM
> > To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: report bad status in GPU recovery
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Might consider leverage is_RMA flag for the same purpose?
> >
> > Regards,
> > Hawking
> >
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Tao Zhou
> > Sent: Wednesday, July 31, 2024 18:05
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> > Subject: [PATCH] drm/amdgpu: report bad status in GPU recovery
> >
> > Instead of printing GPU reset failed.
> >
> > Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 355c2478c4b6..b7c967779b4b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5933,8 +5933,13 @@ int amdgpu_device_gpu_recover(struct
> > amdgpu_device *adev,
> >                 tmp_adev->asic_reset_res =3D 0;
> >
> >                 if (r) {
> > -                       /* bad news, how to tell it to userspace ? */
> > -                       dev_info(tmp_adev->dev, "GPU reset(%d) failed\n=
",
> > atomic_read(&tmp_adev->gpu_reset_counter));
> > +                       /* bad news, how to tell it to userspace ?
> > +                        * for ras error, we should report GPU bad stat=
us instead of
> > +                        * reset failure
> > +                        */
> > +                       if (!amdgpu_ras_eeprom_check_err_threshold(tmp_=
adev))
> > +                               dev_info(tmp_adev->dev, "GPU
> > + reset(%d) failed\n",
> > +
> > + atomic_read(&tmp_adev->gpu_reset_counter));
> >                         amdgpu_vf_error_put(tmp_adev,
> > AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
> >                 } else {
> >                         dev_info(tmp_adev->dev, "GPU reset(%d)
> > succeeded!\n", atomic_read(&tmp_adev->gpu_reset_counter));
> > --
> > 2.34.1
> >
>
>


