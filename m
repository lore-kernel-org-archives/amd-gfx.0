Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9582C3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 14:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C74A10E411;
	Mon, 12 May 2025 14:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2uR62qB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A5510E411
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 14:42:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOj3tBQdRkm57W1IPbZ3CJKwCz4Xh6OiDDB1zadrQbkjJdhtcBkqhizRLQ1pUTzAv8b9jMSOnvq9JFf4yoWyHrGYJuyjIZdk/weWbh3B/rgVu98OiZ61vzHmi2MQVElyZZ5YVEwCCLWinniBbeQiya6TV2f8mG83QSwM7EPpnCLdpZN4uWfV+ej2fofpGoMno0634J16wwL7BffY4vvfxyHRPZfri6m6BrN23/KLhVt+0Et47P7mX5F4TORs+hLbvTbKnU2UQG7nFYrQxfL0cNFsyjJJz9KqZgZp+ZwkdEy+FFwDq2iCELrzvs2sAXL9IgR3JnMvBJvvZc48kfvDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FYTYJQQ7sOMeYnjs0nstZeKeXCYZ5JNzjCW5wFOzNM=;
 b=vwLgHEw51DAX2okKpUKOqCkJY5Gak6YYja19mhWKRQiQ0rF79MoafTBe8eawnOPr79eJDFAD37J9ueR9IygB/mUheUFkicgqZfhDQI17W8JDp4hB2wUiPeoVBcH9SRjNyYlR/3lnzTsycoz1FGmhC25j+c4OKoz1Kj77FPPJe5UiJicy4wVyNMYEI5s8zTfGMTTgbbTEvaemZPahyZgX9bY+1ATNJTQ4F0tiQm00cJ6qnObH8GrHVyxvhdr3xw1WarCsZ/uh6gIF4lDng9sgO+A1da2Dc/y48evUghY7bIkG8B/lFJCztw7A4C/Da5KcHb0joclNWaK3zEqz6Foaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FYTYJQQ7sOMeYnjs0nstZeKeXCYZ5JNzjCW5wFOzNM=;
 b=B2uR62qBS9qw+Z7OULGUytmMSkUSIBhkmCkek1vxO1aasQhMLbiJ0pB/Ldph7HKKtnyCdiSEAH9oIPLBvTV5gUM/c8eX7XF43WAY3T8dRtXSMWMCwc9rWZWAq9OtVFkg+t0/Gh3zwOeK8pFw4Rvsg8FJ25w1HvLjwe6NEyRU9FI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 14:42:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8699.012; Mon, 12 May 2025
 14:42:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Modify the count method of defer error
Thread-Topic: [PATCH] drm/amdgpu: Modify the count method of defer error
Thread-Index: AQHbw0rxFeGvbtLGXkOi2hsz2NpQFbPPEW6Q
Date: Mon, 12 May 2025 14:42:27 +0000
Message-ID: <BN9PR12MB525753F19EC52C3283602AFDFC97A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250512143357.9377-1-cesun102@amd.com>
In-Reply-To: <20250512143357.9377-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=984b7226-638b-4200-91c6-1915157a041a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-12T14:41:55Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB7598:EE_
x-ms-office365-filtering-correlation-id: e29a94a4-94bc-4cdc-5393-08dd9163379c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VRasR+nOg33W6KrbpuGPB4sntCO3K8q8VOBQkKcJrIrm/BvYBwj7opHUnefn?=
 =?us-ascii?Q?/9kUkXpOP7QEZ+N4WdFxbtSP05cK6Vsme6sL49CJzX6371msnijNoOxTd6is?=
 =?us-ascii?Q?yT8L8PJB13bWQMcjTCx9r1VRTi43ALITdTAPnKw6TpK/HapWMKxCgfeIP7O+?=
 =?us-ascii?Q?CBGp2r0rJYwGmVNoCx12xrTXoEqp5l53nM/U3XOsWUgIIRAaSpPSh9CG0yHj?=
 =?us-ascii?Q?arOEilHXZRSxPfP3iBThNSfAUPuQIg8DXlqZaQj2wfQiaTmzG4goIzYi46rf?=
 =?us-ascii?Q?5oli02ZhNS5seCjgZU7IsbUZo5hTbtdr8MSgSzwOlS92aeIQcdDHhvGW3idg?=
 =?us-ascii?Q?SnGXTllXURTVLmqEkawJfYlrNXy477/SjuH5UCdBb7Sq8bamTcX/cL8fYBtO?=
 =?us-ascii?Q?vALbTd5K63dufewIcDqgK4zpeXJVIhtYhobglnj8lUETmvz9aAMik3FpCgg0?=
 =?us-ascii?Q?oc+7oqA3FiSzIicunURMl6w7GPsMulM8/6yEi5BeAxTmBLQYr/GHkGM78yMb?=
 =?us-ascii?Q?wpl+rAbZ80T4DbM6fXlMCsHE7fII1pdv0o1nI9fKId6FwoWtmAmLM/6/0Ox+?=
 =?us-ascii?Q?6ScwoKwkQxWlExEajmfsZFEfWqUBRdfJWJdlpsnDz0F0HUYz+lvaGyfz+5xf?=
 =?us-ascii?Q?CWTv7kEfP1M77Bu8a7Pa0Px/8/2qXrWzMspyDrMfSYvr3wyLY7DgBzS2YPI5?=
 =?us-ascii?Q?R9CVLn7ygeL3u3Ntpt+t3tPRa7/ywDOJ3rtetw/lRMsyV2kOl86mNXNR/ftr?=
 =?us-ascii?Q?p881XJyugItFZlkgbg4NMYBql8CnZd1fGKoXIpOXwhtCjJtYALPZWlbwjztw?=
 =?us-ascii?Q?LVyB/gRc1XiTwouJev75iaBRGKyzDBpmDC7RMUPQuaMU8Iw6YdLa1Wbh4puB?=
 =?us-ascii?Q?aTtB//lx7ru9swXN8aSrwp8wf2Fyqjt/9A2EsW+BvcJiHViTLRx9hy21u2Wj?=
 =?us-ascii?Q?2XVegNwA09LBnrsYr9N1h2LYrKm27ufyNUElT4qFNe7bamKIx1F5AjUu+Iq+?=
 =?us-ascii?Q?fv1CDOqxz8XYGjTE1b61B8ACHZ1x1fo3rD/kPdKsoLsyKDdZWXmR4edsekxs?=
 =?us-ascii?Q?BGitJifFu8mdI/0cF53Y/M4haurtkzoXL9qp4nSV0mnnllN+iWQ20Z379b//?=
 =?us-ascii?Q?+yQk1QeJOmW5NY9g123kRWXGUj9MQf5vWbdFD46/8QjDaCy5dak49S7bMrkX?=
 =?us-ascii?Q?mI251yEZACf9PvVPgNqLYnRDtq/fRXNceL8eSk5PzWKkisaP7mQsVUCxMiQL?=
 =?us-ascii?Q?gl7TPRyprhLOjP4/sJTq8a5n6gQNUeGN3MvWOYfsDMOojCPGx5NIdNQyjfgx?=
 =?us-ascii?Q?Jmvk5zGMWphtDPOEL5wlhQWmldNSlBbkIveUEJfHnDnCnvey41ItNtCFC1/M?=
 =?us-ascii?Q?MwHljS/P4QkF1Ppot+z6SDCn+y4fhcyeUc8EFa9DX9wZSEt9cTOnDBeg/ZXh?=
 =?us-ascii?Q?nfIGxR1mubyuHg+0MCWvgYHu1AWFB1EXWCtuNr5Zq8t4tucfArkk4+E7mD7m?=
 =?us-ascii?Q?be/j4wTYZBzn6G4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L9hM8p2wj3V7KQu/s7BHfujNwqkYpgFcN3yWd0ICopso3eI5T6N+aVmmVCIP?=
 =?us-ascii?Q?YbFAeSEzVmocK+wdDrrj37h6dp1vMZ56BLS8OUpXOgu++IehmIUU8+QuDJ4O?=
 =?us-ascii?Q?iBsG8J4FejFEMDi24BlKVjosYMBEMFhIOBwqUIGXq3gtBCG09ZfiYXiZ13SC?=
 =?us-ascii?Q?zhVTpCzjtohWqtTgWxsXeuuREiusITFZIT/L3ym39wngtmwbPL9Tj/6d2drb?=
 =?us-ascii?Q?VVPTLMJIk1YrIcA8iaRrktQLBW4DdrfUhzJcEWf21MhgdvBxiWRF6Gzb15rj?=
 =?us-ascii?Q?FOPZ8D5iLBU4rKSPCohkVnwxAYyAgRGDwEdcIw6QFqdG1DsxwNBuS499jzUe?=
 =?us-ascii?Q?3SCoLwGlEf/apMcq+du91tinTNrxXjiDYKEBmvQLBXeCVZbyeD47WiR+9xfv?=
 =?us-ascii?Q?YqKUyvteFRYI4w9zlHHf7m6ex8wgagm9UADaKNmnFpCMi3HdhXzedDDb+eu4?=
 =?us-ascii?Q?Qk+L+3atdInJ/A82qm3Z7s/pTGUkGxA3HW7HOX/Z2ilkJaw8BqfXYwYtcmRT?=
 =?us-ascii?Q?dAcPds+NI2Gx+8Lebpnc2TAR51gDUVbq+R4KuI9Lsbx4nEuG8QMvGSfd0Sg8?=
 =?us-ascii?Q?8/nDuQYaXh3+5MfVhEgYegTxZA39r5SU6RYHfDTeCCha7x7S7sJkosi/IQAz?=
 =?us-ascii?Q?kY1u5ihyq+HrujZ2pBd9rq7Q4JlNarJIjDLaVc+fpHeiaYUX295hukibeW2Y?=
 =?us-ascii?Q?iclMVTzmXM7cWM5gzzFxogV9KWZ8KEDAEslRVwDBckir+jkGhPemQGeMiqej?=
 =?us-ascii?Q?UG/RTJGN/d+cYT8hzfjGeZufYhiFOegrvs4HxZV6X6CKFAo8fF9dCPDJBVrc?=
 =?us-ascii?Q?FB4Tkjt0b5ss+p9lLLwdRsZGV2Rie3rNE9CQg+pXHgl6Cmt9lUsh7T+AUw1o?=
 =?us-ascii?Q?d9I5CdffjUgBfW6XIKoVevwquNyTc+Ek4OnjPb5zpuXGKRwz641QiJFibQ4y?=
 =?us-ascii?Q?ECPfLuT3SIjhy7QtiWdQSE4nlHhAJnjZB0a5dyi5YCy2o5FcHzFvl8w6DYwY?=
 =?us-ascii?Q?qzDQyBLofj4RE/MJXNiuSMFMfB/d+sVwD/Kwcw5DWZDTv3oo+A4ZnYdoBtVF?=
 =?us-ascii?Q?VO4ADIYx9Nxye2+ogC+CZF7AE1zEaut8Y1aPd9iRIHkdzx6QklMqoJrdYVfV?=
 =?us-ascii?Q?BfYp1v152eMtfvtBjze/0cwCcqq2DuLV0UtASf1w73rs0596OwdpavVCW7IJ?=
 =?us-ascii?Q?6I4TcTMazzZ7URmrvl3RjPGLCqkohlBO0Uz1D34KLa9HGkwpeDcgeIDiImBJ?=
 =?us-ascii?Q?7xTxGkFUimeHQcRYIxmhdXnJpocF4kfuVytCIv0pjRXjS5b35m4k8bEyYmk7?=
 =?us-ascii?Q?uymkJWVMWTdJtkGyiJY2fgCjDdoTtV/Awnogh2iAOuXIqSct0kxlpN9POhUI?=
 =?us-ascii?Q?/OJh7vTZgvazoJNUicxRxCbYahQpjaiqaeclyoZlZfYTh9k6mvza/iYyFBfj?=
 =?us-ascii?Q?LcIms6MECEm6bmv0qEq0tPwnmQr9fGfXOa/CaufPenkW+eiYjW7QY1Uqt9Q7?=
 =?us-ascii?Q?3kqnIVxdcNHziX3+rCQWzwgtjotgbT4SSFsFETuoF/vvFrceW4T2ctSDZvyl?=
 =?us-ascii?Q?ixufhcW1qxpsj5nU6IA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29a94a4-94bc-4cdc-5393-08dd9163379c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 14:42:27.6672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQ/ZWIwo3lB4SXdUO8JxLJWc3VO/hONmoVCDEWKPQtH323GUBGE98T6jJVFY4wNbXySafhIBcprXEBGbkI96vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598
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
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, May 12, 2025 22:34
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Modify the count method of defer error

The number of newly added de counts and the number of newly added error add=
resses remain consistent

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 1 +  drivers/gpu/drm/amd/amdgpu/=
amdgpu_umc.h | 1 +  drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 8 ++++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 8adceeee298b..c19e40d095a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -533,6 +533,7 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_=
device *adev,
                pfns[i] =3D err_data.err_addr[i].retired_page;
        }
        ret =3D i;
+       adev->umc.err_addr_cnt =3D err_data.err_addr_cnt;

 out:
        kfree(err_data.err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index 857693bcd8d4..52fb71c4ce9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -130,6 +130,7 @@ struct amdgpu_umc {

        /* active mask for umc node instance */
        unsigned long active_mask;
+       unsigned long err_addr_cnt;
 };

 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev); diff --git a/drive=
rs/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 0e404c074975..0a4ab63287c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -428,8 +428,12 @@ static int umc_v12_0_aca_bank_parser(struct aca_handle=
 *handle, struct aca_bank
                bank->regs[ACA_REG_IDX_ADDR]);

        ext_error_code =3D ACA_REG__STATUS__ERRORCODEEXT(status);
-       count =3D ext_error_code =3D=3D 0 ?
-               ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0]) : 1UL=
L;
+       if (umc_v12_0_is_deferred_error(adev, status))
+               count =3D ext_error_code =3D=3D 0 ?
+                       adev->umc.err_addr_cnt / adev->umc.retire_unit : 1U=
LL;
+       else
+               count =3D ext_error_code =3D=3D 0 ?
+                       ACA_REG__MISC0__ERRCNT(bank->regs[ACA_REG_IDX_MISC0=
]) : 1ULL;

        return aca_error_cache_log_bank_error(handle, &info, err_type, coun=
t);  }
--
2.34.1

