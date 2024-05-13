Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB16C25B4F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 02:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC9310E146;
	Mon, 13 May 2024 02:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NERanjvn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8C210E146
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 02:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gw24C2EvBfsYGQ0Gr6EyTB1SBQtgn0QjK3ZiFnGtgU1EbG9BwipggkLl0no+2Onox2eWDEGS/KFQKQJw4ce3rtn75ibf6AWAtQq0gJwnuFm5evGKXhgW2l3RzC5OUh4dEJRGXtUvPJk4kErSmg5Wrsw+xPt+4+IYOB6Obw4P4QPeD00ibrmV6Z5CrXRs54UZoGoguOHsMYQRX07pUkvwskVJQRjcHMi7fgak9V8iGUW5qGhgEkvzR8boZaWPSUpnILP58BNnNuOmtqr1zqaKNbgxKaIKJe7LrACD6QNr2bDcK3utn4jjgNVkYiu8tBzvS2rXDHEnY+fQXngWAxP0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6smdxclNvQuXX7ROtaHQIRL5YGkcE1R8/OlelP+l6U=;
 b=WioIcyfYXqNtnezXLh2ZVZmYm3esdfgF3xG1zI0grjsylDRNIIo21xPW2qsFj5E8LiSYFPB25qvMPnSASVnvEcGEZfxhMwqbrFnsmg0AyVzmwTpDaYNvVg+eusaNtZE1AWuJRnf133UaQqiZ6BhXSSgjzCyzoZZ6fk0sYLoRTJHsG3Ta8v2boNQzjwQoL7TjN3/77/XX6JSJXifpSqNRmyrTBm+8TjGVxGoMYW2J5oqNE8yHc/tLqm+0Cau91iel89UDX+6Lq4tyEj3ezaQ6mEx2s5aTvpP73GkpHPhzxk5TS+GsF8XLGEW4rM4hhSq77LJVAqNiqEkKBujl/37LAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6smdxclNvQuXX7ROtaHQIRL5YGkcE1R8/OlelP+l6U=;
 b=NERanjvn6qrZ4mDUnO+myfvHQNXf+tPPoObG+TB+Fh/1Y5lzk9zhN1+abVLcGyDMJ6nLenloa2tEJCPVwZBK5mATjEicunE5M0USeUTLtnEx6HZVLVWIReKD8k3NcwfAGibLCBJ5szxien3dFp3wk19R84Msg69Kb+6ML6Onof0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 02:19:00 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::1ba2:8035:9950:d11b%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 02:19:00 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Topic: [PATCH 18/22] drm/amd/pm: check negtive return for table entries
Thread-Index: AQHaooVbpJ/WLViAjUW/rc+cFqzwP7GUcr1A
Date: Mon, 13 May 2024 02:19:00 +0000
Message-ID: <DM4PR12MB5152F766B9A117B703AC21DDE3E22@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-18-jesse.zhang@amd.com>
In-Reply-To: <20240510025038.3488381-18-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=0cae49d9-55a3-465b-b45d-61e2f78e0db9;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T02:18:49Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|BL3PR12MB6523:EE_
x-ms-office365-filtering-correlation-id: 3a51eba3-fd1f-45c2-4309-08dc72f30d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?rNaSv9XLUP/op00CCpPcQ1I3QEPIeAyfoqbnskoZCAthjlsHvYauSn8vgFPD?=
 =?us-ascii?Q?g7ptuB+6w10O5DqD6BtsFg7313pbacDDYEtABMziIT20XKCHkvxDYBJdR/Jf?=
 =?us-ascii?Q?MzrOXTDD6AnmSCqBkVmR3yfYrDkO3rsW29giFqIvdpkaC0hahDJcDKZ34HEv?=
 =?us-ascii?Q?5e5sP9C6k7PG4cQCqNFWLBkqAjQPPGY7XPsO3xVq0D+suf6ZrJjn9rBr4JzY?=
 =?us-ascii?Q?4AHwTRXcFPBrsrQfd6oyrbBvKJtN03Y3SKxWvU8CU9rHKSOn6stQyb9aO6WR?=
 =?us-ascii?Q?sbjt9dq5ysd7ArlqpW0MG0tWyWGcSRwp/8G+DGkrolycVvuMAP8opalwG+ht?=
 =?us-ascii?Q?wZ2vwUYMpQZpycK4hVvWPx97FR2zoJJnXe5s8KXij0diZtAA/GTRaQbXCZoM?=
 =?us-ascii?Q?tX1xspiKD5y/dqgmRVupokromGI0SMAnugboWkysJuR05h9EGbWIkOQmljKK?=
 =?us-ascii?Q?gBGKCT1vwh9jkuKI/CXbuS9YBgh0JS1lsM+XVhz3BZGt33vHtMq0AxOn3E24?=
 =?us-ascii?Q?T7P0qgm+WAJRuq2jOSakezu4M93On2gEFFLdMzByq8WgmpG5rvXczRfeArmt?=
 =?us-ascii?Q?hirVvIcVzMjZxa9qtgSi6eqmkfRdLAsd4t6MVoeujMA37pLElhJSXFcrwr+d?=
 =?us-ascii?Q?GLk6bmm19Y/jJZ+iPOskVDTBgjXTuFSyugWz9pJE+GRFL7H2dMg2/n8s7MRp?=
 =?us-ascii?Q?Nfa2d+BYt6HT29Kv1Fl0628VxBBYgM/qoHPvDBM18lqU0ZrAV/+tel8hrQpS?=
 =?us-ascii?Q?rUZeUKwlJ/yK6nzOeenxms4iornifvRHQsMj3dmqKUDGeUohZYbwyyVOAnXS?=
 =?us-ascii?Q?cBjd1N5fNmmBHequbUpyX/xCOl/dDRx6rAUGhqKlsIpH2D8AGKfT6OWyOpe+?=
 =?us-ascii?Q?6+DJK4qYJ8YGg5xkZXiJHkIKg//N1TrN4ybADDgJEd1qAPbywNwcsF8N0tm5?=
 =?us-ascii?Q?4q/FzvEIMxZE4m+mFb7OK+vP7bX4SRuRvlCkOwQjrSLd6CA3ibCq5itXzw4o?=
 =?us-ascii?Q?AVHUgJxdFNlLtKnSepn8sf6PxLtJ9+AGio8oWgkYVpLssneo8jyTMnBz9cn2?=
 =?us-ascii?Q?3WFEMUkNrKuqJzOQo1eyiyhbJP+kyG2DjLkHXNGJkId0Q3PqdvDv/5LP2BVc?=
 =?us-ascii?Q?qzloajMvNmGepuIaijqLzn6Z8on37M+3oy2kFL9AQEbwfDhAG0OLn0xsM7v5?=
 =?us-ascii?Q?UsUGTrPzxW0IWTRXhnarb4UUmYzstc9LBIm1vlBGXOCQn5gvjihWDbCkVZrS?=
 =?us-ascii?Q?0Oro8whbLUV3Oxz0nzhPv9Aom71fO9SQv+3qGQxRUuMG+EIxn71mAU1W65tg?=
 =?us-ascii?Q?FYI9a5ThZgA5ANGscsUHJcHe2L+mV5ERDZYYn1+fcC7o3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pRt3Um3F5sUNs5NfglzhNypN0MdLjAI+h4lDPQ8F/CzISmzreKyPuEoxPJ95?=
 =?us-ascii?Q?ltmnghu4OaBYpvZrvMgSSaI4ydeFYFJE4w/9O+64eiHhC7jNMBNgfW7WiNws?=
 =?us-ascii?Q?uhf3UyskEZ9pX8NXRaPxMH7h5tLIEIA4qICwNj9sDUvSuH9VS9nntBmlDI+j?=
 =?us-ascii?Q?fv4z1pXp5o5pJF5PeOZZPpN5hnmRs1WlxaYPfPJtyQFsJEnxk+NfqK2rg09c?=
 =?us-ascii?Q?L97t/1YbJTCRaSzL1MJFAYUewMJIIX0BSuZpDB0TJbWbAECkeDdYtMoKQodo?=
 =?us-ascii?Q?2/irTWCPVlq4vmRbtbgrVFN9kzw0FZ53R0JM8AjqYdGO/xTSbWrsWMzz8GiW?=
 =?us-ascii?Q?lnPekNrR6NCXw+wT6rMbmM+9r+CGtiHsckM1/vuPJ03KAnPFXzwWnYPXzNPX?=
 =?us-ascii?Q?9Q5HcMa/VyI5YfB64vHO9LME8b0sgLzWBmjOOlw15xL5WVHKGp34Q+gUQVsW?=
 =?us-ascii?Q?XVJFt0z3Sgg+7u+/z9Wl7UXypK/cXht6X6OGnIijCf75OsFg+IuxId3DDdOS?=
 =?us-ascii?Q?k9HOJdjMrUJ6YOvRtGQ3hsEzb0PHz0KVxboEL0latVCBEqNwce5s0VY1j2+f?=
 =?us-ascii?Q?pVoepDG2VBDhk/pKvWoWDVLNJPp8sST263glW0I6fIjPhrQGv2hmEKADOXmZ?=
 =?us-ascii?Q?xSwGt8f29njWnJCuekFryPwk5O9PnVUe6hG6w0+ih07AAe5rCoC5N7SJC6z0?=
 =?us-ascii?Q?Nfi8EB8QbARAgiIkcOXbhLDj1AQ2zRljIQ/TV/B0ysfXrKxzt6nWdcWR2rFU?=
 =?us-ascii?Q?UmnFsN/uozH5UTHfRUAwumVigeeJzPsiVDyOnGcLx94N83WJDqvOBkBoz2t1?=
 =?us-ascii?Q?c18/VZek/bIwLqc1A22ej8YoqxluH8qfA5KKzDTkDgdTtvXpasologD7pFH6?=
 =?us-ascii?Q?K7Ugu4y/lBFdXwgMQz1IGp2K3WRNYRLp2hWYRO7x9dgsMv1JhxV53tMZqgvz?=
 =?us-ascii?Q?IEWMbIdsAvJwdGnK6tyIWwY2Hn123THdaw7lJp86AgiQYcpr/YWdkXvHgtzs?=
 =?us-ascii?Q?+MO2LU/XAlPbP5faF22VOrJ9oaDAh7cdN/BKCaGthatxdWln+zK1lnJpbO1m?=
 =?us-ascii?Q?TG3TTBApbWrLrjgHOnkZhrjRUAYEPOG1mdPMDhAF/I/K7iuDyp6F9RnYX4gR?=
 =?us-ascii?Q?eXUfwzMhc/b76aiDIenIVn6kDN80jJh49/igFpd3B/7mm7GAHDgEdESMMv16?=
 =?us-ascii?Q?7nJ8M8FdD+IJx0cM3+M6ZGvV4/0NN6PGte3175twDNNy0sL7uyw2I0P7KvR/?=
 =?us-ascii?Q?ghVwPM71kobild3knI7sZ3DxPIoqf17WqGu51i7hkEcePV/uMDlvi11zwOwv?=
 =?us-ascii?Q?x2v86/rCOh0RTFwzg+Z9lE/nUvKldo126h86XOYYkxeA67iVKK6QVjzGUiDV?=
 =?us-ascii?Q?Xvt5sGQz4uxpC2B3JH6S6rtdP3w2lYm/75OgqQ/CqglzNGozhVQCfeuNm+cX?=
 =?us-ascii?Q?HHb++QSUOAhHf+/zQZh07msk9k2vrMoWL4EehihsaROU5t0SqypHG7unU8Jv?=
 =?us-ascii?Q?tnjTnlkuJ5j2gywYbDBlYBfThXkrI/hCdB/F3UGtKEVLmfhn9lN0E7PhHFVi?=
 =?us-ascii?Q?J4E8byHunIhHJMsYejM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a51eba3-fd1f-45c2-4309-08dc72f30d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 02:19:00.2877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKq/7CWaf4da9hmObofzjeoC3NnR4IFJQKFa9yP7/bTWNlc9md4yFtR1fohs1FFFaOrgUTxbj+REhtL5VcztFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

Ping ...

-----Original Message-----
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Friday, May 10, 2024 10:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 18/22] drm/amd/pm: check negtive return for table entries

Function hwmgr->hwmgr_func->get_num_of_pp_table_entries(hwmgr) returns a ne=
gative number

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c b/drivers/gpu/=
drm/amd/pm/powerplay/hwmgr/pp_psm.c
index f4bd8e9357e2..4433ec4e9cf2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
@@ -30,9 +30,8 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)  {
        int result;
        unsigned int i;
-       unsigned int table_entries;
        struct pp_power_state *state;
-       int size;
+       int size, table_entries;

        if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
                return 0;
@@ -45,7 +44,7 @@ int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
        hwmgr->ps_size =3D size =3D hwmgr->hwmgr_func->get_power_state_size=
(hwmgr) +
                                          sizeof(struct pp_power_state);

-       if (table_entries =3D=3D 0 || size =3D=3D 0) {
+       if (table_entries <=3D 0 || size =3D=3D 0) {
                pr_warn("Please check whether power state management is sup=
ported on this asic\n");
                return 0;
        }
--
2.25.1

