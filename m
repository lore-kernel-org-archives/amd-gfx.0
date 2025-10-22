Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78C6CCD1BC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1E710E030;
	Wed, 22 Oct 2025 07:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="adKE9N9k";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F290010E030
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwBQrA1UDScUdhuSGB31/rc9BoDbUMH6wmE4MpTK3MDaxNZrHeyoy/DjqKwG82ieb+ZkMOgpE7wbWwzGH8UAUdTbM7Aonc2z7aOTdItDCToIerwPkxGuiennNv2Pjwpy8cV/lk8E9JeEfnCl44tXJGmvwgnaFtEZ5golvjH8BBqiwwo6J8Gsp8x04I2PoariXdsNrxAGDSQuWdrNNnjOxUqrtj75Nh5a86X76pr/Q7bn69lzG9ZHde44hVMkMY5BpPLDZ9JJj0dApGFt8aZukSXYDl4Aj0nk8aUMJcF9zbkgjFLsOYVDDpB23YZXAgBSRu5UlAQEaI5JMMLOyeSpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CppVwcf4JlLuChPFS1NFaLmHXudAhE/uhjPMR+c6/O4=;
 b=rKiVEJTYGBc4qpApJzL37CM6O0d+6vBjp/+f4uJMA2PT9xLy9pihDPKp0aLXchsD/+eh/jqU3hOhHDVmc82dvvP3J2He944m3EfEK2x50LMLcG4/5DsKE9iEPsRyqXf6hX1AHJyhnbDvBuSHm+ZPA/pnYvSJtX8zSZxRCeM/5BXB1xK3/BSugjleF7Hoouruk0Htg4/s+vKg7Y8FJbPytPvih5LrqL8tuO/u1acyWOCjNLGiFfNtDUe5jLhMzr9OOb/Z/dbuE+ZdUQ1j+f3/DiOsytsJb8Q/4DJU6oM6b4kNuC64mh357wl9oA9h3gP+aP9s8WE3DBYUWs8OH4+wqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CppVwcf4JlLuChPFS1NFaLmHXudAhE/uhjPMR+c6/O4=;
 b=adKE9N9km+7fWQQ/0H9nNuWEmI9PDFA1RdyW8vzhoPxuA4bJt/fx/p4w9FIraRVeehQd8xNFsJmSqnu/w1mwzLaGeLXEDpSyzIxDfUJw8hIHj6Oe20otFBM867Yw9fES3KNkhJ6kKmzT+0T9na39yAWWoE/2CTrxJcjUPvwupio=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:41:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:41:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix smu table id bound check issue in
 smu_cmn_update_table()
Thread-Topic: [PATCH] drm/amd/pm: fix smu table id bound check issue in
 smu_cmn_update_table()
Thread-Index: AQHcQx0oxShFCerdhUGu9TDHh7X327TNyEKg
Date: Wed, 22 Oct 2025 07:41:37 +0000
Message-ID: <BN9PR12MB5257638D5BB5F3E1B00CEE14FCF3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251022062848.3526151-1-kevinyang.wang@amd.com>
In-Reply-To: <20251022062848.3526151-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T07:41:14.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5882:EE_
x-ms-office365-filtering-correlation-id: 6565ef8e-22ec-4b9f-f70a-08de113e6eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oTXDg8LAnwIQuDehhZ24+V2N0KeAlOlPyVyEVev15i7rUJd1ZfzerPSXAjxP?=
 =?us-ascii?Q?T7RDTEHAR0ATy+nmx9x7OrypmAAyhzUbFvo9BzwGcA9Vin+0Wkq4S8yE6qbv?=
 =?us-ascii?Q?X2qgRi70SXloPrX/rfxcgPw8mTbD/tpvpgIhjv5/Yy9fiNl+GrUs4/55V5Bo?=
 =?us-ascii?Q?JtwxIxVbSGMcsF5tpAUldadljkM/ydJxKrbdPdOW6FLksBTJfSlrx9kV5unD?=
 =?us-ascii?Q?jd3h4SiLDw9Jp41X3SqPsy+y8+GC7zquowi3cD7tqY16foQs4f0nEoqTuWVl?=
 =?us-ascii?Q?te9RRdafjthzCCs0nIoaL+M9/enZPyxHhrxdbLaBZIaKWaRjlZ3+E5NPoiQ3?=
 =?us-ascii?Q?cYpQU3Y2/frl3CAJUgVfxYtUSqUmUNel0gcDlnCv7kTKzOgEzlTsUktGr+TU?=
 =?us-ascii?Q?vmuMguPGup1ujp5bm2pFWRywv3tPbyKAjlVb9hfRzWXQqDXDPNOc0WQAQeiH?=
 =?us-ascii?Q?AbzLJvOHlC64inWIXWLg8g8y9S4IwA6alTX2c+4iPT9BQE8uOQvZT1GxNj7x?=
 =?us-ascii?Q?Kew9GOcw5vMZamPNsa47nEJomK4US1KxE9BuAf8KTgrCxP7C3EoC+WR60ki3?=
 =?us-ascii?Q?dvLmWD537x0S3vuWr+VGzu4sg9wihnBjRPNcbnFKtutlIyO/3f41rdQUoO6u?=
 =?us-ascii?Q?k7lsNAm3TOw7NbWqe3bdCtI24DznhoAj11NBi8AFsso7V9OOdjdxDR3xPgKS?=
 =?us-ascii?Q?n0XoiL6j2QvAlP3pwh0qe+ggcDZ39w30siGUUY31BRU0/M5te0z2QE67Ktlw?=
 =?us-ascii?Q?PyfTWMUcBe7EtzwTvcsWx8C0u1Ho179SryzfTh8oxtY8kW3D+6g0NmQt6nLB?=
 =?us-ascii?Q?Ozea4a0Ltjuz3i05tOcmqk5EZKt0wW/QOdeuPESb4Qf9hS7BAHziiskeiBXy?=
 =?us-ascii?Q?E0vx6p3LJdECWR+8SiWodokcIUvlnXPMI8Q6aNhKMjSE2MZCc+gwNwQfrn8y?=
 =?us-ascii?Q?aqhVt4CJvhNL5lLaRdx1f69Z4ka5yXMyFqP0EkhgZ0kbyvJ3oRk61pMy7YUb?=
 =?us-ascii?Q?jRuALSvA085lwnWYdL6MSiTg3kRMvQrCHkwqFL4Z1mBe/UNousm1lip493Ek?=
 =?us-ascii?Q?e6V2Y78CZ2A3XK8qEhX32c1QiaJgy4kHm/YPYxpgzSVudzk7oKj7NWFDdeQw?=
 =?us-ascii?Q?QL7JV5MGYXvvV0tEZELZ7oX8ax2LwRyXRS83unG1errJLsZdqUe8IJfo676N?=
 =?us-ascii?Q?wWcvsxBtXvEh5LtTp0SQGFr6umJmyQCGSMyj1Kqog4dR3hZncntix1EvdmVN?=
 =?us-ascii?Q?3zlBm2gIuu4IB9emrfIWkxqNThuHwEFBnixJ1tvJmnEDJ6L2DmwH87pvKrnL?=
 =?us-ascii?Q?JBd87+QOJFP+lltT7JGOPwmTeP00MSPELGf5iK5cP6waq3sSSbyihSMp9ITj?=
 =?us-ascii?Q?5ThZvBcUfftyDmJqdEuhmc97eoW5Ta6WLGFH0MuEj/AM73KyO4RxtnDuqjRS?=
 =?us-ascii?Q?GS8TF65L3qEL0Y8YGtnlHbzwoNOIkgJaLGVtCCxhhUMaAnIQmgtXOW6Xs9nl?=
 =?us-ascii?Q?o86+7HBwCxxl3vSHEMiMQt9nSmv7Ok9B+DsF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJy5hKCNny4IXXz5f+YztogoGkcZV/aFlclPUA0CXfXH77NMphLGW2iXwOl4?=
 =?us-ascii?Q?SgREVNjLeeVpMOIM/It2Ifoz+Um0UPPOP4JR2YjWB8319OWoFevxNiAApR9v?=
 =?us-ascii?Q?Kmy6XGmS+SzFcfCeEB34urKMzHE2qskv23M48Tec74Q8+54T2p6EmFiZswX4?=
 =?us-ascii?Q?gt9dI92yFaQ7joho1SYF1idEa0iL5vWIEZscCeaASDvWEc1KHkwiW495XW++?=
 =?us-ascii?Q?vGWIOF67IiRJx2YZgYKgeQvIw+/psYRfQ4a0lVflAEAKvOcOErc9gnFOfibL?=
 =?us-ascii?Q?Ktuw0IUYUjVFOPL9bQyryF5sE7oaUmdABMokjuQ3MYTf2AkclHFm+ZqSeUUw?=
 =?us-ascii?Q?dPTjy8tFbn4hAYm5CSOsizf2okgswv654PKeNdgYt9a97wkEln+QORUtIRC+?=
 =?us-ascii?Q?9PHHQU+otoAQBjSj3VPbuv6nRunezhpRBJ0REvRFUTsBA9Sg3mKO08h0XZ+p?=
 =?us-ascii?Q?ieUucnpS8pPlTX8J6zNF4V4s+IjazaZI6MjgvPUD/LxWmc4RJgL6Kt9mPW1B?=
 =?us-ascii?Q?46Kn/IZ63uDGzSDCRKhMuy4VnwopVCKkOTQYLdAsUqcZvoxt/2qDvGCwyzeN?=
 =?us-ascii?Q?JWv5REJF8OpeZH0OdSF7/1PL+MAoG1CL50cAzuKMbgiBxjS4Oc8zACB91c0X?=
 =?us-ascii?Q?JrsETQy6IdVCXz2U+lYPC1VTN0w+mUOfwFa0pdYUVwMrrkDq/NokBZkKPJWR?=
 =?us-ascii?Q?QnMkwqxFl63H3cPfsSplwuRB/Jancv4tUNWTeolc8DaSOwMP9LM9pASohSSz?=
 =?us-ascii?Q?zf/xf9n2YodrrRMmQPGSZdickBGsWR/V6QJbnnkPaVA/U0WtlqX2Prn/fK9o?=
 =?us-ascii?Q?pQA7tIjGTDNYBSLnsJvvJbzsRQAuPD2IiYbxExEnujYUA0vYNngQugbrfGTz?=
 =?us-ascii?Q?IR0qjb5Qp2i4k90unbQV8IlvaKCMPoydQYU3ONduHEZDkI0zO2l6i54t2wxe?=
 =?us-ascii?Q?V18Xrfh5F2NJn27M0R8yC7nTj6qfN1JEewWOzpGIsGjHbCrXTE0WcWOLjl2S?=
 =?us-ascii?Q?uloLY4vANm1Ofdbq/s6APgPQQhVFFgkRnfmkWoAUwkQjJBjRBlbvutA53moJ?=
 =?us-ascii?Q?7XipHZWhNsj2oBfqnXBmzCpRODWkUoANl9nIyoI0E+o9NPEM4JloMUrSTbwe?=
 =?us-ascii?Q?qGJyxBaYmwdD9NvsRTZU28KixxwVU+Vrtos37V4/wPFoL1/tUGL7CpesvpmY?=
 =?us-ascii?Q?OssPdh4mSYOd5mqAQYZm9AJwHpmgI0JD7PlCrvNwv5rED0G1upeSUU+6vETs?=
 =?us-ascii?Q?JNnD2JBlEjWMyaBICV1S0r03ce9zyragu9ytCuGzDq4cKhRXjOFpNwJtIfdL?=
 =?us-ascii?Q?Y9wdbvqRo6D959nQfazLgSU/+ouxazZvtYbD7um8GCGKbb7zEOSFYfqDHl18?=
 =?us-ascii?Q?2hGARiUdG6k9xvV7pBAYIaqfjycR3rmYJg8g2pUuoMGmd5odycXRrbT1q5E8?=
 =?us-ascii?Q?tZbfqzJyjdKNUsECkpDO7kRWH6r0l4h3pHAcwnxVyS1QKOimVG2fCuGg4ybf?=
 =?us-ascii?Q?YhUnkXleSdEwe6pnkNar3ZLba5/L8LGX+ieRNsYq+Cb5yPZKJ+pMHe205Vj1?=
 =?us-ascii?Q?aC6HhkoF4WtMaSQQrmg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6565ef8e-22ec-4b9f-f70a-08de113e6eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 07:41:37.6059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADEzc3kasv5LyG7r6MzofW9Neo1esFh6f8DeeLX4/QNSKnsTZdV/7IhrHMcE9ZLzykX8bBFR7ggM3QL02KUIIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, October 22, 2025 14:29
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amd/pm: fix smu table id bound check issue in smu_cmn_=
update_table()

'table_index' is a variable defined by the smu driver (kmd) 'table_id' is a=
 variable defined by the hw smu (pmfw)

This code should use table_index as a bounds check.

Fixes: caad2613dc4bd ("drm/amd/powerplay: move table setting common code to=
 smu_cmn.c")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index f532f7c69259..a8961a8f5c42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -969,7 +969,7 @@ int smu_cmn_update_table(struct smu_context *smu,
                                                      table_index);
        uint32_t table_size;
        int ret =3D 0;
-       if (!table_data || table_id >=3D SMU_TABLE_COUNT || table_id < 0)
+       if (!table_data || table_index >=3D SMU_TABLE_COUNT || table_id < 0=
)
                return -EINVAL;

        table_size =3D smu_table->tables[table_index].size;
--
2.34.1

