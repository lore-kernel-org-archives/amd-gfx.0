Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237E1D70DF6
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 22:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68B210ED70;
	Thu, 28 Nov 2024 22:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rOpm3vq3";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B7410ED6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 22:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQSdo1VtMsSNR61gEvIYDO2ZPkxJWpUmMY9udyTBXh89o6woZ0ln6i5wYH56MebWRqIq7Zxt0OtJSAZEm9ZgLf6K30dkNxiaUvAGT5ySQGj4mXwmiWy8kwWhl7vu9QVyvEnwLMgnTWJMfc4EWINhM7CYlFICn7XqDUZnGgaP5FF6ggb2tzgX/AZJV4N4pyjsHgK2K/NwcrtuvvgLMKB16VWShbldQz3h64Ul2UgVVh3fGN9Xg+Z89goTm/AoP5CvZGLiyoMtvUbVNr0krbpVhAz+eCDkhSmmEWdVFR94/OF1WKwVMbM/llPPSUgP74/G9yBqsCUQovrBGh6iUq52pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUJD7DqCE9b32/JI81PFR2/JOvOVROAZN9ion2mjmeI=;
 b=s1bmUan1pUzF56FcWa7kOCi+6wPMZim+Y+5m8YppN6W5SmRVOcFenYwV8GBb8LxkJfCq1WCNN0La7/UDaoS85RnzmRq9HPXDjYmjfQsIO6bkWyArYH9wMgfgJvfurDHzJQHgFmzISnYeAzw++DaOimdSp4Aakj9JrMtYFl7pZKeBURWHQHLeWCHIaqgh+YGH98xjmOKf+eajeGMw2fCmjth6Ym3wpFU+qEBNRpmuVlYwi3otEbsFB8QJTqnzbgcwVv1OrI9K3s97SzRyh+c6YkKe88cQDLhG9NUjEFtYpFaJZafVBTezqkLmPD+NRqY0rdh6XZ8Q/xRd5WkC8+RUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUJD7DqCE9b32/JI81PFR2/JOvOVROAZN9ion2mjmeI=;
 b=rOpm3vq3sS625gA7Yp8A/h8hFPcaMTgpPjlKn+qJ13ji7bKoU1CYFCiwmey4F3zCeaiyMQt2KxUvqe8bebb9I4Tmwh8u3AsDm6u9e/MRhJ5VLi56BCAg69BoyCZOzwouqnSxxzm3aF5g/lmpAv43zG2rC2CemCcIgehNRjE3VuE=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 28 Nov
 2024 22:23:38 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 22:23:38 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: add MEC version that supports no PCIe
 atomics for GFX12
Thread-Topic: [PATCH v2] drm/amdkfd: add MEC version that supports no PCIe
 atomics for GFX12
Thread-Index: AQHbQeO5qHBFTMWxwkqyFjQtWCu7abLNRGtA
Date: Thu, 28 Nov 2024 22:23:38 +0000
Message-ID: <CY8PR12MB709962E2C6418A1F83D55E1E8C292@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241128221956.300635-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20241128221956.300635-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=d2a15453-0c33-4d4b-a0c5-9f4f2d87f865;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-28T22:23:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|LV8PR12MB9335:EE_
x-ms-office365-filtering-correlation-id: a6f93aa0-4a4d-4620-f930-08dd0ffb4e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mXvpJmMcrEpDAVZlsuXhqKHKvcos2Xl+5YHUdvJoHTozpFvtG+oaYkiqp4gK?=
 =?us-ascii?Q?VPa4x/vVYLi+FhW2iDCHGZ2N2K0C70uWR/vzAo1ma1nBzqxAfw6cA2AmCnIJ?=
 =?us-ascii?Q?GIwa6nsHt4rixpY8tGI6T5yyJLsWcF0OODGsXThaU5to120CRBca2wVD8+fl?=
 =?us-ascii?Q?A0jb25hG7oI/FB0qo8IjiMdp6smfLcdGiVUHgtGOfxvOSoewRo8+a5X4qyfk?=
 =?us-ascii?Q?HIOpqB2j059SDbtJd7KtCLljuZceJPn2pdcwARLA0n77plpiifno0aE7wog9?=
 =?us-ascii?Q?dqFvzUaMdAkQU9ru1e1L+YeKfmHNoJWlU72fmlNh6jSVFfaWw9JL4USrq1pY?=
 =?us-ascii?Q?F406rGobUE0mxlrF9wtc9WSH0CYGIfFKm8oh7mAO5JB7FSwL6B7dUF3BvMc0?=
 =?us-ascii?Q?rWNbbyNWD7UYEN9Zo/NEugD003iRO05Bm0c0NNRLt2bCuSizsIF4cq0V+prD?=
 =?us-ascii?Q?37vGqL/Wj1K+ULky1zrwUKOkfzP475+N0IIJHMnn2VmAHgniXwAa2uk/L75a?=
 =?us-ascii?Q?oiSsNatwGRKPSQBQ03Kx2aDfjFnRbHBRVbOvaIRblFFILZ1ONviaD1XkzBYY?=
 =?us-ascii?Q?l07LTfiRMQhNchhzzg6PaE0z2ukdaIuFCBHwetci6xGwWpS+3pqUBjqN8rMR?=
 =?us-ascii?Q?J02g3eQsXvH2gAqKFUUl5hW6QWqzXn8hakIXKzijnhv8W0WgUEMnQ0WUe3eg?=
 =?us-ascii?Q?HBCRwJgzQXdmERrGwsApHA6i9GwbOLPhFsPK8ZIWpOktYBDKSRc9knxWTt89?=
 =?us-ascii?Q?OXvtT7HtMIBhCyFQ77cYQdTohHvyfvCLI+Cp6PVMzhM0SmmPtwRSRNiVpeqz?=
 =?us-ascii?Q?x8pJJrvWkWUBB4YhCBLUg1lzUgX50Gyt9vPVXWWWVgo+fSACM/owJPUucSSZ?=
 =?us-ascii?Q?CB4YjNwZWh/DK+jfmIzCl4UyS/dbrFICvXWwc5CwOElLsldGWkXi8HDFM8lx?=
 =?us-ascii?Q?r+fMQZgOCQPp9w51w7xIit3pgDuox8QWqGxyCx2T8MLlT+HZTu+BvNT449jw?=
 =?us-ascii?Q?viAgSB6CWjuc9JmMBKYmUSvNI2y+CzkQA4+cvgtzYeMOheZ6CbZ+kn2CtUC5?=
 =?us-ascii?Q?TUxdY0XVYYnUxiHlvzvMco0zQGfFSp1qDJq/bPURGedgxt2NRlQqotRetnvI?=
 =?us-ascii?Q?6ckA5OUwgxO9tuka2LyVyQDQVHhiVSRSB9uzIY77VTLvnnQmnX1dKd7Dirbi?=
 =?us-ascii?Q?6+OQ4iaZPbf7JeNGNVdX3Lab6qqI751l4xsAWCLT+I9CaU7vhpcg3+GvXeES?=
 =?us-ascii?Q?NUwm2eXescjSyM3wSrVbCvDdB/WyDIjJNkbyChU1RrPc5fQo1Mn1NOdz64tS?=
 =?us-ascii?Q?uDL+3r2DEe6pn/uzKZbHfOH6sUx24royRpwLoYJNI3XDIV35dFU6onVzyU7M?=
 =?us-ascii?Q?KsjWe1fcCCqvHbievlOlFqcmpQP9LsskpHLTDGqoKy1+mhgpKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V9cFhO2AtaO2/Noz8ocP8Q+FC3YfJetUS+sduowRecMuQj6ajDB/ql/eHQEk?=
 =?us-ascii?Q?qoVLosPzJGaOJI+Hh7RaG8UZQAUwqYvkyu3fAoL6HzZO+BwL8icwmYAmh5V/?=
 =?us-ascii?Q?tF+Aj/3pMxeVu0POBwzF382+PgGGAwjbLyj55O53lvhCrSeQIFwiLwY8eowY?=
 =?us-ascii?Q?0yJtUhiHIlSvI1+Mirid9k46QUfWDWJn7qFY6ZntLSFkP+KHThaDz4RIWJXV?=
 =?us-ascii?Q?uDlhbw/Jc+TS/mgUsJK41okD2LhpuFT9We95z/txjfwpAXRzUv5GU9qbFRzr?=
 =?us-ascii?Q?nebrNHWKuyUZwtpj30yhMWLNue+rAYahe0qqyo652CpPmIUYuDYGOqC9Dv2D?=
 =?us-ascii?Q?Nd3Trpyf2K5oZlyoKWwjlULlqZZuURRhxupTz3ecHu5kDO7AI7Im3aZLlg4h?=
 =?us-ascii?Q?D0RDxGY40+1TnB0V9EYXexqIpuFmGbIHGHAg7rez3JSIrNI9qhBHD02hVZNa?=
 =?us-ascii?Q?tNfnaZ0dWroxxQtYxXq4J0u8Q3jQvACCcbkLtFj38va48Hv7URyIF2ETczKJ?=
 =?us-ascii?Q?PKWp9vHMaBgsKoa4cDSxQzBMBVhXAmnvT/g0vU0MJITANokIbQtUk/Szs/1f?=
 =?us-ascii?Q?m/97neH89GFk5DebkP1VXT2xpzCtk69rRMsSRTN5sfuKzNdjzCibCf8CgBgZ?=
 =?us-ascii?Q?S6Wpfrt3jGbtaluO40HyFvB2PdU/uCXs5LlEbu7pJp/j4vUVfoGqkHgzxLbQ?=
 =?us-ascii?Q?gl4bpxY36cBQGhnEHYqm/LQwu3PSp3F4TSG2F8mxwKxMUzknQ5AMJAzvS/8G?=
 =?us-ascii?Q?SP+m6VnROrjredl0/3pDMl8rX1xOZVIrHzFVA2LthV+EOY5muHEV2zZynDSo?=
 =?us-ascii?Q?u+6rbugdnEuTXbmgolngsL0PlX3Zyp9GEXWMDXiDiDfjFwmMj/NtU36G54js?=
 =?us-ascii?Q?Btg2iSxanArrG7GGIX3Wj90R9/ep65Tu0Ia1p3DnEc2DK+phOa1xoyokEtq4?=
 =?us-ascii?Q?jBhX7Qf21bQ/tgbFNGfR/oNKveL9QHJt/cJp62Q2vVAobAwPa6rGTJyJVHi2?=
 =?us-ascii?Q?nd6iYMAxEB3D/nDxBPVw9bPTE92JbA5PjLjlsrrM+Db9UYnYf7taXQWvIZI4?=
 =?us-ascii?Q?OHglE7UUxxiG4p6Wn0w3l1UZtNOoB+Vo/xrOnGsfVeYDc3svxgNajzQWo3Xv?=
 =?us-ascii?Q?+1ZeiIw0CjDAl8r1WXXrc4GA7UUSEDY9ljxNSeoB9ySKmItyBchGmQSjGYWu?=
 =?us-ascii?Q?hjdx0qH82yI0ElvbGH61Kyl899XoQnrFhXxEnFtSla49MUYkdh2GTVqqjzLq?=
 =?us-ascii?Q?X7Nveu9NfNnfEGaPVcG2FcU74h+KfCpgJ5DmOMyU/1HDP02XxIHZ+GVG7Rhu?=
 =?us-ascii?Q?e4OWMhYosDRye+zPXHmjx1zIgPtJ6HIyksOSM3XE58hXVHaUv4ssXOZjEGQZ?=
 =?us-ascii?Q?iFlnTxSU2puGhkJgEoQoxAjLbmL+1slsqMwIBAM9wFD4ROKRh3EUa+4GSTj1?=
 =?us-ascii?Q?YqaG9ly4PUO4F/UDOdC9CD85Z8Th1NRTcDoq5+VkA/STNCrYy+Ux/9MGrTPW?=
 =?us-ascii?Q?t/kQMOOEtDtgz2p1FYQ0BbvIJP5LJa3QHXlLVo6glGGOPO3I8lCY4QVGiWMe?=
 =?us-ascii?Q?hK0oD4YpT4qbCYnkQns=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f93aa0-4a4d-4620-f930-08dd0ffb4e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 22:23:38.4206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTLXv16ECSeQ3tURUOHagmhSZne3V0TkErkSduwuks5vVVnsd96e5jJXpFJ9yc6VEAUw+lqa1zumZ6+T+wKK5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreekant=
 Somasekharan
Sent: Thursday, November 28, 2024 5:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
Subject: [PATCH v2] drm/amdkfd: add MEC version that supports no PCIe atomi=
cs for GFX12

Add MEC version from which alternate support for no PCIe atomics
is provided so that device is not skipped during KFD device init in
GFX1200/GFX1201.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 956198da7859..9b51dd75fefc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -235,6 +235,9 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
                         */
                        kfd->device_info.needs_pci_atomics =3D true;
                        kfd->device_info.no_atomic_fw_version =3D kfd->adev=
->gfx.rs64_enable ? 509 : 0;
+               } else if (gc_version < IP_VERSION(13, 0, 0)) {
+                       kfd->device_info.needs_pci_atomics =3D true;
+                       kfd->device_info.no_atomic_fw_version =3D 2090;
                } else {
                        kfd->device_info.needs_pci_atomics =3D true;
                }
--
2.34.1

