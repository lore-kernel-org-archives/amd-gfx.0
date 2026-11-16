Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E09606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SDT0/gxS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A524810F425;
	Mon, 16 Nov 2026 19:55:36 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 272E410F425
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 19:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z31B/W4mPXehJYS8aNwswCn39Ajf5hMdh4LGyMp1F1T1MIaDONtcU5eL7LTnpnLvl3PV6YOYUvG5bszRBor5bMD5E2hnqXwuTA62ZIKyZaLw0OMg3Gw0glJz683WeirIlQctCJ80osJ/Sr7Ii2nPk/3ctzsy2pgeMh0tRYkiDMY6BbwMi7UnVM2YnmqTHpmniYq93HOA8olTb+r1MOUGBXzqOmZVqZyjdyjEu4Xlkhclo7+e/FbxZtUnTCZvQHQCMLfKBHUTbaqfXiwxcxFQqvJd/3mjap6W28bQaFZzyZq2CGYTW0S/leSAONL5Racg5jg2Gyq8XmidDYckwAFP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI/LS/0MmegX1w9809pw5o3E8KtDSHbEYAMGKlAeZTI=;
 b=YfKj28KisY2akZqsQHd/gPo0vnW4b8lERPiWJTa6Vnr3Xk9Nu/WG2xo5MIUtrvlt7vxbLk2G4L06No/NnzTOIRkhKpW6Glm8XxMvD/SoRSA5E6h7II7C7+AOZNKFc2HNhO81C3IPCCZ4xa7a0ntwtTKM+b1VUe6ywygcoMTcTM5j0HUobXU6k8g5CJ7+69qXQMzFTvSFbHclQFdW3RifPbEoP86cibra6629ovece0Jvlzw/2YbHboU71DW23jmSIyQvh1UgVWfc5bHQDPXsF87TxMPE8XfnxGDBkaFcMEEB9nFoPTHNcEp/LKDCd0bsJ2jxxiW/eepBTrYmaxOdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI/LS/0MmegX1w9809pw5o3E8KtDSHbEYAMGKlAeZTI=;
 b=SDT0/gxSXroZM/R23737sAkseanG/cUIs3SkJkBsyKZpTAzSm9Z6BIWv40QwniQVKf5CUU0SWfOsKz4XE9qDfAWsHLANpZPIvCEROmsHiM/tEdu8rVVcPRAKBF3x96BkUOwNXU2KrR4c5rsBP7PwCzlUzrZVzEjky9/dIr3/EXM=
Received: from DSVPR12MB449095.namprd12.prod.outlook.com (2603:10b6:8:4fe::22)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:53:24 +0000
Received: from DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0]) by DSVPR12MB449095.namprd12.prod.outlook.com
 ([fe80::76a6:7a4f:a0a5:18c0%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 19:53:24 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 126, Issue 488
Thread-Topic: amd-gfx Digest, Vol 126, Issue 488
Thread-Index: AQHddf5teS6Ku7gje0+IWeqcRoqTiLcxHBhr
Date: Mon, 16 Nov 2026 19:53:24 +0000
Message-ID: <DSVPR12MB449095DB25606D7FB40DB17A26817C2@DSVPR12MB449095.namprd12.prod.outlook.com>
References: <mailman.24703.1794856330.6452.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.24703.1794856330.6452.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-16T19:53:24.169Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSVPR12MB449095:EE_|IA4PR12MB9833:EE_
x-ms-office365-filtering-correlation-id: e9676899-b2aa-4a12-fa11-08df441b4692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|6049299003|376014|23010399003|366016|4022899009|1800799024|38070700021|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|4013099003|4053099003|13003099007|8096899003;
x-microsoft-antispam-message-info: IWYn1DbpPuIoHMo9PR5qzOLxOW1YMXjRg1rOLRiIyUOe0PPcbYesZoqfonhb5K4BzFDI2D+KMhfbSiU2c12ObPrdUzLkI3MdU+zb9QBfupnuYvgNibnXj5hxtSNSV93wRxfO+ALLQgxFWtseFsRqJvsakPjrdM2MrVV/nSoAydd+hfGE59XCdhgt9MlZ3htiaHf8TbNERcNLiR1BTZgLQgkAAPApsMmGPgUW8rp7fswhx61CfYBX6E4IzJ2J9eGSrUjB3OQLPr3rU/11w57CL04RaNwMNF0tua8AvBxTC2e4ZDSKN+G9MbyoA+1VLnZHygrPTgGj0qRjl24Z8cOgcjohV/BjxgjHEC1zDcSZ708c41G+L0UnVCPvnOQ8XzNCzyV1R22kOL5PSQCdgbLLQnotoA9XFQUhKbex38P5YBoHJdfk8ly4hSEXo3Ftw4G/l1r0AlKcPsRkTRB1Vk/DTthd1DryJ4x6nYdM42asmS7jXDcLcmJmOdVMZWDOoa2xU6+hASHcbJBiNOpm0ptq+U/lX7HBAlrnDosGWfG5uZnc5FFDZFTwdoRWpQKQMlzZcUMTmmMFhF1zSIbr07X3G1aPCqe1rpxbUbjpXfxS00uTfyTu/4Am0G+A8eLHQbB5E85/N8DWCL27d3KEvHgrkgliNSAK1qf1+mwOkMeLXGw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB449095.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(376014)(23010399003)(366016)(4022899009)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(4013099003)(4053099003)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iSm2qQm4kFJ79ET0CtKixwFmBAj5QC0Y/T8JepZa9Sd9N8WltwnqGDhJEc?=
 =?iso-8859-1?Q?MpfnYro/4Mn/WHtfKR0Z3ciCWMNPjVXwp6no/mOLnTeys5c8KdEnK1xe3r?=
 =?iso-8859-1?Q?jUWPKebeEfZkzzvooHeOa4+/VVOFOHnCjj+pCb2SfwyQBlXGW5pJD0sc8p?=
 =?iso-8859-1?Q?8gwGW6urdddGXUrifHiGLj3W/8uVX7yqMOtV+lKsQY6ndDKuRtCvVMg9pq?=
 =?iso-8859-1?Q?7WxaVTrsqMkzD8v6GwYXqCeMAl2obMX+3+zmEC6iiUfop2bBh+8i5dhlZz?=
 =?iso-8859-1?Q?ek5MHF+gpGEbQXm945m0avOPVVIWdPXdYaN1mAdgYSFCjLaSVkWmCIF9C6?=
 =?iso-8859-1?Q?WI2l0RI51RxuFRKqycoipF2lX8AhY7bOYtjc+fOW+z/wzpuYdMGzIW/UxP?=
 =?iso-8859-1?Q?OeX3Mvk+YbCLFwM7CDavzKjz1EUHUv0dASLUk9NHFzN6hF0AZKR3F0VqXz?=
 =?iso-8859-1?Q?Lt91h0OgJ1LoVBiqUtVPnJqOhBsflgi0eDHWftU9qpMAdITbl94oN8w2ZT?=
 =?iso-8859-1?Q?B0b3JzCLP0c8loBTF2kDj8KCWeb6Yhq/rg6+gXeC7TRxCX2+kkRqC54wCT?=
 =?iso-8859-1?Q?zdxeaYmgBinfCWqc6E8X7N9QDv7NmF9cJARV3AT7mLv/S1h0emsiEEmPW0?=
 =?iso-8859-1?Q?Nfvo38BuVeCIj1PvRBCuGD0kjgftoS0SX1ihwyV/0L3bCUFfYZev7icL+s?=
 =?iso-8859-1?Q?At+wz98qEfrS3s6MuRi/v0m2HPc4xroRCNAtzpE5tKbTcMmBJCRlzeNEi0?=
 =?iso-8859-1?Q?b1AME6hSalnGb7JTF/1E8iEqYU+YL1YQQqrzeqmzkvO/m/FGuHR8jo53An?=
 =?iso-8859-1?Q?Df1b/0Tia6+1XUD3EuUQfB+DF7Q2bq/5Zf4CltttbMgVkziFCDu/6QWKfP?=
 =?iso-8859-1?Q?r9RM8N2b8/23ArqWiUuZvi6bf3MjmZN3ZTuGgmwKRd4M3z1ZbA3sMCF3HD?=
 =?iso-8859-1?Q?I36GjOHdXCm2o1+KYBlIjiGrCxX0vtPD8fhdhxDl6SLW8Ch6j0OMN2Pv44?=
 =?iso-8859-1?Q?WUjkINvv/hM4ySBDwhgc6Ed7kkeUqcST6os4wjyAk6r5KXFPNyoc97n+3s?=
 =?iso-8859-1?Q?geutTAOKT3K3uUDPsmPcxE96huvEEDLMl1QuQFj4WHL2FuxFCto+NufXgy?=
 =?iso-8859-1?Q?Kctp17QCag0BjnlPZKnvv2VBVJ2MAvSa7927+o5eR9aEM9rlg08aS2lhgn?=
 =?iso-8859-1?Q?0UvL0o63SZVAo35bhVqKUH8b/qS8FQhw+KjACYEUjQr9ZoFAt9YmimLnqG?=
 =?iso-8859-1?Q?K/OrLo9JZNHfwqQWhzX9TW/f4Jyn4o7y4dbztUoB3vKhdW4iaaIUmdAaOF?=
 =?iso-8859-1?Q?OmFeZdLLRBhLufH+Z7XyoAYDmgOOxz/Wbm07bJtfASF3NjpwOMjbiNftWA?=
 =?iso-8859-1?Q?7If3mTuAesAu8UgHxwzVIst3Erdfm3Ms1fIfgSzgJ8VTF/wKW3rLI+FBaD?=
 =?iso-8859-1?Q?ilW0Q4Pr0W+9HYg+CqdmCQVGln6u/5G4vbNlrMKGk/gcTfefwrNaluOFuU?=
 =?iso-8859-1?Q?ojRAP0GV7TtpwZp3wP6WExKJ5HtUT8yUsLbDLwwUZZDkSXn11R4L3x6aST?=
 =?iso-8859-1?Q?FQYqQY9wu6iYXJFk5YMf+crqkqu4x0CeRh5WHHs2bMTRBXyDW9myIH6/3y?=
 =?iso-8859-1?Q?9TtbyMu6hdcTw0MnWxUzLNspX23dZ3yCtgNf4p/EtNbZIWs+akr2SVrJuD?=
 =?iso-8859-1?Q?cgybN97Y473VpY2oVsfCbzh/ZoKDCf+xVxH+DMaJ3Ybl+iPSTLVkChS1lX?=
 =?iso-8859-1?Q?9AfBNBD7Boh76ayxKvctshfAiwxwfFu+JNE1RX9lEFqJOv?=
Content-Type: multipart/related;
 boundary="_004_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_";
 type="multipart/alternative"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB449095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9676899-b2aa-4a12-fa11-08df441b4692
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 19:53:24.8629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGumaMRQInPhX5IHBcQTYoL8Px03oUDq8p89y/4zOms4ONhG6h6QSHKe43kOrdaA0MuRfeQXE6s4LiISyuvhPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_004_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_
Content-Type: multipart/alternative;
	boundary="_000_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_"

--_000_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General



[cid:b9da4edc-958a-419d-b902-61987424214e]<https://outlook.office.com/bookw=
ithme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlots=
EmailSignature>
Book time to meet with me<https://outlook.office.com/bookwithme/user/5be71e=
58d07c492d97048217b901df8e@amd.com?anonymous&ep=3DowaSlotsEmailSignature>

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of amd-gfx-=
request@lists.freedesktop.org <amd-gfx-request@lists.freedesktop.org>
Sent: Monday, November 16, 2026 2:12 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: amd-gfx Digest, Vol 126, Issue 488

Send amd-gfx mailing list submissions to
        amd-gfx@lists.freedesktop.org

To subscribe or unsubscribe via the World Wide Web, visit
        https://lists.freedesktop.org/mailman/listinfo/amd-gfx
or, via email, send a message with subject or body 'help' to
        amd-gfx-request@lists.freedesktop.org

You can reach the person managing the list at
        amd-gfx-owner@lists.freedesktop.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of amd-gfx digest..."


Today's Topics:

   1. Re: [PATCH 1/5] Revert "drm/amdgpu: re-enable SPM updates in
      the the IB path" (sashiko-bot@kernel.org)
   2. Re: [PATCH 4/5] drm/amdgpu/gfx9.4.3: program the RLC SPM in
      RLC resume (sashiko-bot@kernel.org)
   3. Re: [PATCH 5/5] drm/amdgpu: bring back the ring parameter for
      update_spm_vmid() (sashiko-bot@kernel.org)
   4. [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in
      RLC resume (Alex Deucher)
   5. [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1 (Kent Russell)


----------------------------------------------------------------------

Message: 1
Date: Mon, 16 Nov 2026 17:08:47 +0000
From: sashiko-bot@kernel.org
To: "Alex Deucher" <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/5] Revert "drm/amdgpu: re-enable SPM updates in
        the the IB path"
Message-ID: <sashiko-outbox-217409@kernel.org>
Content-Type: text/plain; charset=3Dutf-8

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdgpu: missing Fixes trailer for reverted commit
  d44428868e5b
--

commit 36fa0c29e9f1b1b0ebcda0c9f28cb357bd14196e
Author: Alex Deucher <alexander.deucher@amd.com>

> Revert "drm/amdgpu: re-enable SPM updates in the the IB path"
>
> This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.
>
> This causes flakiness in gfx11 CI tests.  Revert.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

[Severity: Low]
Since commit d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the
IB path") carries its own Fixes: tag, should this revert include:

  Fixes: d44428868e5b ("drm/amdgpu: re-enable SPM updates in the the IB pat=
h")

so stable and backport trees do not pick up the original commit without
this revert?

--
Sashiko AI review ? https://sashiko.dev/#/patchset/20261116165713.1945549-1=
-alexander.deucher@amd.com?part=3D1


------------------------------

Message: 2
Date: Mon, 16 Nov 2026 17:20:11 +0000
From: sashiko-bot@kernel.org
To: "Alex Deucher" <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/5] drm/amdgpu/gfx9.4.3: program the RLC SPM in
        RLC resume
Message-ID: <sashiko-outbox-217426@kernel.org>
Content-Type: text/plain; charset=3Dutf-8

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: gfx_v9_4_3_xcc_rlc_resume() passes 0 instead of
  xcc_id
- [Medium] drm/amdgpu: moving update_spm_vmid() to
  gfx_v9_4_3_xcc_rlc_resume() skips VFs
--

commit 754d99a96da547c9e401d40cfbeb309d0d3aa36f
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume

This commit moves the RLC SPM VMID programming from gfx_v9_4_3_rlc_init()
to gfx_v9_4_3_xcc_rlc_resume() so that the register is reprogrammed after
suspend/resume and GPU reset.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index da031caa4e9e6..151336e6094f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(s=
truct amdgpu_device *adev)
>
>  static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>  {
> -     /* init spm vmid with 0xf */
> -     if (adev->gfx.rlc.funcs->update_spm_vmid)
> -             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_mana=
ger.spm_vmid);
> -
>        return 0;
>  }
>
> @@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu=
_device *adev, int xcc_id)
>        gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
>        amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
>
> +     /* init spm vmid with 0xf */
> +     if (adev->gfx.rlc.funcs->update_spm_vmid)
> +             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_mana=
ger.spm_vmid);
> +
>        return 0;
>  }

[Severity: High]
Should update_spm_vmid() pass xcc_id instead of 0 here?

gfx_v9_4_3_rlc_resume() and gfx_v9_4_3_xcp_resume() call
gfx_v9_4_3_xcc_rlc_resume() for each XCC instance, and
gfx_v9_4_3_update_spm_vmid() uses the instance argument with
GET_INST(GC, inst) to select which XCC's regRLC_SPM_MC_CNTL register to
write.  Passing 0 programs XCC 0 on every iteration and leaves
regRLC_SPM_MC_CNTL on all other XCCs at its hardware reset default of
VMID 0.

[Severity: Medium]
Does moving update_spm_vmid() into gfx_v9_4_3_xcc_rlc_resume() skip SPM
VMID initialization on SR-IOV VFs?

Both callers of gfx_v9_4_3_xcc_rlc_resume() (gfx_v9_4_3_rlc_resume() and
gfx_v9_4_3_xcp_resume()) skip calling it when amdgpu_sriov_vf(adev) is
true:

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:gfx_v9_4_3_rlc_resume() {
        if (amdgpu_sriov_vf(adev))
                return 0;

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
        for (i =3D 0; i < num_xcc; i++) {
                r =3D gfx_v9_4_3_xcc_rlc_resume(adev, i);
    ...
}

Unlike gfx_v9_4_3_rlc_init(), which ran during sw_init on VFs as well,
gfx_v9_4_3_update_spm_vmid() is no longer reached on SR-IOV VFs, leaving
regRLC_SPM_MC_CNTL unprogrammed in SR-IOV one-VF mode despite the
amdgpu_sriov_is_pp_one_vf(adev) handling in gfx_v9_4_3_update_spm_vmid().

--
Sashiko AI review ? https://sashiko.dev/#/patchset/20261116165713.1945549-1=
-alexander.deucher@amd.com?part=3D4


------------------------------

Message: 3
Date: Mon, 16 Nov 2026 17:26:33 +0000
From: sashiko-bot@kernel.org
To: "Alex Deucher" <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/amdgpu: bring back the ring parameter for
        update_spm_vmid()
Message-ID: <sashiko-outbox-217433@kernel.org>
Content-Type: text/plain; charset=3Dutf-8

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu: hardcoded XCC 0 in gfx_v9_4_3_xcc_rlc_resume()
  skips XCCs 1..N-1
- [Medium] drm/amdgpu: gfx9 compute emit_frame_size exceeds max_dw in
  amdgpu_ring_init()
- [Medium] drm/amdgpu: update_spm_vmid() skipped on SR-IOV VFs in
  gfx_v8_0 and gfx_v9_4_3
--

commit 08b45306962b59cde3c232193cc26534f308aaa2
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu: bring back the ring parameter for update_spm_vmid()

This commit restores the ring parameter to update_spm_vmid() so that GFX9,
GFX10, GFX11, and GFX12.0 emit the SPM VMID update on the ring during IB
scheduling while skipping MMIO updates when a ring is provided.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index df935827b002a..e818280139791 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4084,7 +4084,8 @@ static int gfx_v8_0_rlc_resume(struct amdgpu_device=
 *adev)
>
>        /* init spm vmid with 0xf */
>        if (adev->gfx.rlc.funcs->update_spm_vmid)
> -             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_mana=
ger.spm_vmid);
> +             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->v=
m_manager.spm_vmid);
> +
>        return 0;
>  }
>
> @@ -5483,10 +5484,13 @@ static void gfx_v8_0_unset_safe_mode(struct amdgp=
u_device *adev, int xcc_id)
>  }
>
>  static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
> -             unsigned int vmid)
> +             struct amdgpu_ring *ring, unsigned vmid)
>  {
>        u32 data;
>
> +     if (ring)
> +             return;
> +
>        amdgpu_gfx_off_ctrl(adev, false);
>
>        if (amdgpu_sriov_is_pp_one_vf(adev))

[Severity: Medium]
Does returning early when ring is non-NULL leave mmRLC_SPM_VMID unprogramme=
d
on SR-IOV VFs in one-VF mode?

gfx_v8_0_rlc_resume() returns early when amdgpu_sriov_vf(adev) is true befo=
re
reaching the update_spm_vmid(adev, 0, NULL, ...) call:

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:gfx_v8_0_rlc_resume() {
        if (amdgpu_sriov_vf(adev)) {
                gfx_v8_0_init_csb(adev);
                return 0;
        }
    ...
}

With amdgpu_ib_schedule() passing a non-NULL ring, gfx_v8_0_update_spm_vmid=
()
now returns before reaching the amdgpu_sriov_is_pp_one_vf(adev) branch, so
mmRLC_SPM_VMID is never programmed on SR-IOV VFs.  The same issue affects
gfx_v9_4_3_update_spm_vmid(), because both gfx_v9_4_3_rlc_resume() and
gfx_v9_4_3_xcp_resume() skip calling gfx_v9_4_3_xcc_rlc_resume() when
amdgpu_sriov_vf(adev) is true.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 2e2673a6dbbf5..be45c10b6f579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

[ ... ]

> @@ -7663,6 +7675,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>        .get_wptr =3D gfx_v9_0_ring_get_wptr_compute,
>        .set_wptr =3D gfx_v9_0_ring_set_wptr_compute,
>        .emit_frame_size =3D
> +             5 + /* update_spm_vmid */
>                20 + /* gfx_v9_0_ring_emit_gds_switch */
>                7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                5 + /* hdp invalidate */

[Severity: Medium]
Does adding 5 dwords here trigger WARN_ON(max_ibs_dw > max_dw) in
amdgpu_ring_init() for every GFX9 compute ring?

This increases gfx_v9_0_ring_funcs_compute.emit_frame_size from 145 to 150.
In amdgpu_ring_init(), max_ibs_dw is 150 + 125 * 7 =3D 1025, which rounds u=
p to
1280 with align_mask (0xff), exceeding the max_dw of 1024 passed by
gfx_v9_0_compute_ring_init().

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 151336e6094f7..f28ffe8a5ac55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1586,7 +1586,7 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_=
device *adev, int xcc_id)
>
>        /* init spm vmid with 0xf */
>        if (adev->gfx.rlc.funcs->update_spm_vmid)
> -             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_mana=
ger.spm_vmid);
> +             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->v=
m_manager.spm_vmid);
>
>        return 0;
>  }
> @@ -1609,10 +1609,13 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_de=
vice *adev)
>  }
>
>  static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
> -                                           int inst, unsigned int vmid)
> +                                           int inst, struct amdgpu_ring =
*ring, unsigned int vmid)
>  {
>        u32 reg, pre_data, data;
>
> +     if (ring)
> +             return;
> +
>        reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNT=
L);

[Severity: High]
Should gfx_v9_4_3_xcc_rlc_resume() pass xcc_id instead of 0 to
update_spm_vmid()?

Previously, amdgpu_ib_schedule() called update_spm_vmid() with ring->xcc_id=
 on
each IB submission, programming regRLC_SPM_MC_CNTL on all XCCs.  Now that
gfx_v9_4_3_update_spm_vmid() returns early when ring is non-NULL,
gfx_v9_4_3_xcc_rlc_resume() is the only caller that programs the register, =
and
passing hardcoded 0 leaves XCCs 1..num_xcc-1 at their hardware reset value =
of
VMID 0 (the kernel VMID).

--
Sashiko AI review ? https://sashiko.dev/#/patchset/20261116165713.1945549-1=
-alexander.deucher@amd.com?part=3D5


------------------------------

Message: 4
Date: Mon, 16 Nov 2026 14:10:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in
        RLC resume
Message-ID: <20261116191022.1955106-1-alexander.deucher@amd.com>
Content-Type: text/plain

The register needs to be reprogrammed after a suspend and resume
or a GPU reset so program it in rlc_resume rather than rlc_init.

v2: pass xcc_id when calling

Fixes: 7c0f7ee00c7d ("drm/amdgpu: add gc v9_4_3 rlc_funcs implementation")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index da031caa4e9e6..7b8ff043c99ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(str=
uct amdgpu_device *adev)

 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-       /* init spm vmid with 0xf */
-       if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_mana=
ger.spm_vmid);
-
         return 0;
 }

@@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_d=
evice *adev, int xcc_id)
         gfx_v9_4_3_xcc_init_pg(adev, xcc_id);
         amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);

+       /* init spm vmid with 0xf */
+       if (adev->gfx.rlc.funcs->update_spm_vmid)
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, xcc_id, adev->vm=
_manager.spm_vmid);
+
         return 0;
 }

--
2.56.1



------------------------------

Message: 5
Date: Mon, 16 Nov 2026 14:11:41 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Cc: <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
Message-ID: <20261116191141.145348-1-kent.russell@amd.com>
Content-Type: text/plain

This feature cannot be properly supported, so disable it both on the
amdgpu side and the amdkfd side.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       | 12 ++++++++++++
 .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
 drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 08d3ff61edcc..d0ede277aa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *ad=
ev)
                 gmc->noretry =3D 1;
         else
                 gmc->noretry =3D (amdgpu_noretry =3D=3D -1) ? noretry_defa=
ult : amdgpu_noretry;
+
+       /* XNACK cannot be enabled on GFX12.1, so keep noretry=3D1 */
+       if (gc_ver =3D=3D IP_VERSION(12, 1, 0)) {
+               if (amdgpu_noretry =3D=3D 0)
+                       dev_warn(adev->dev, "Unable to set noretry =3D 0 on=
 GFX12.1. Keeping noretry =3D 1");
+               gmc->noretry =3D 1;
+       }
 }

 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_typ=
e,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index 1f57d0fa2c04..034cc3fd07f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_=
device *adev)
 {
         u32 sh_mem_config =3D DEFAULT_SH_MEM_CONFIG;

-       /* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
-       if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) =3D=3D 0)
-               sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT=
;
+       /* XNACK cannot be enabled for GFX12.1 */
+       sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;

         return sh_mem_config;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 3d2136adb62b..3b62b9e5ecda 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *file=
p,

         mutex_lock(&p->mutex);
         if (args->xnack_enabled >=3D 0) {
+               int i;
+
                 if (!list_empty(&p->pqm.queues)) {
                         pr_debug("Process has user queues running\n");
                         r =3D -EBUSY;
@@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *fil=
ep,
                         goto out_unlock;
                 }

+               /* XNACK cannot be enabled for gfx12.1 */
+               for (i =3D 0; i < p->n_pdds; i++) {
+                       struct kfd_node *dev =3D p->pdds[i]->dev;
+
+                       if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0)=
) {
+                               r =3D -EPERM;
+                               goto out_unlock;
+                       }
+               }
+
                 r =3D svm_range_switch_xnack_reserve_mem(p, args->xnack_en=
abled);
         } else {
                 args->xnack_enabled =3D p->xnack_enabled;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
index 525989371378..63ba13a60b98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *=
dqm,
         struct kfd_process_device *pdd;
         struct amdgpu_device *adev =3D dqm->dev->adev;
         struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_GFXHUB(0)];
-       bool xnack_enabled;

         pdd =3D qpd_to_pdd(qpd);
         qpd->vm_cntx_cntl =3D hub->vm_cntx_cntl;
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager=
 *dqm,
                 qpd->sh_mem_ape1_base =3D 0;
         }

-       xnack_enabled =3D KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
-                       pdd->process->xnack_enabled :
-                       !pdd->dev->kfd->noretry;
-
-       if (!xnack_enabled) {
-               qpd->sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__=
SHIFT;
-               qpd->vm_cntx_cntl &=3D
-                       ~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVA=
LID_PAGE_FAULT__SHIFT);
-       } else {
-               qpd->sh_mem_config &=3D ~(1 << SH_MEM_CONFIG__RETRY_DISABLE=
__SHIFT);
-               qpd->vm_cntx_cntl |=3D
-                       (1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVAL=
ID_PAGE_FAULT__SHIFT);
-       }
+       /* XNACK cannot be enabled for gfx12.1 */
+       qpd->sh_mem_config |=3D 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
+       qpd->vm_cntx_cntl &=3D
+               ~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE=
_FAULT__SHIFT);

         qpd->sh_mem_bases =3D compute_sh_mem_bases_64bit(pdd);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 546721b4d59a..059e22cd7f1a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, b=
ool supported)
                     KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
                         return false;

+               /* XNACK cannot be enabled on GFX12.1 . While dev->kfd->nor=
etry
+                * should propagate this requirement, adding it explicitly =
here
+                * will help cover any possible future reworks
+                */
+               if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0))
+                       return false;
+
                 if (dev->kfd->noretry)
                         return false;
         }
--
2.43.0



------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


------------------------------

End of amd-gfx Digest, Vol 126, Issue 488
*****************************************

--_000_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" data-signature-name=3D"Book =
time to meet with me">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<table id=3D"pbpsiglinktable">
<tbody>
<tr>
<td>
<div class=3D"elementToProof"><a href=3D"https://outlook.office.com/bookwit=
hme/user/5be71e58d07c492d97048217b901df8e@amd.com?anonymous&amp;ep=3DowaSlo=
tsEmailSignature" id=3D"OWA7a7649f3-0d5f-9cfc-c9bd-4638de7f490a" class=3D"O=
WAAutoLink"><img size=3D"528" data-outlook-trace=3D"F:1|T:1" src=3D"cid:b9d=
a4edc-958a-419d-b902-61987424214e"></a></div>
</td>
<td></td>
<td>
<div class=3D"elementToProof" style=3D"color: rgb(0, 120, 212);"><a href=3D=
"https://outlook.office.com/bookwithme/user/5be71e58d07c492d97048217b901df8=
e@amd.com?anonymous&amp;ep=3DowaSlotsEmailSignature" id=3D"OWAcd436431-1b74=
-9710-34d8-2e7013f95001" class=3D"OWAAutoLink" style=3D"color: rgb(0, 120, =
212); text-decoration: none;">Book
 time to meet with me</a></div>
</td>
<td></td>
</tr>
</tbody>
</table>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; on behal=
f of amd-gfx-request@lists.freedesktop.org &lt;amd-gfx-request@lists.freede=
sktop.org&gt;<br>
<b>Sent:</b> Monday, November 16, 2026 2:12 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> amd-gfx Digest, Vol 126, Issue 488</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Send amd-gfx mailing list submissions to<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.freedes=
ktop.org/mailman/listinfo/amd-gfx" id=3D"OWA35d6e93a-7250-8629-244a-326bbcc=
05667" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
or, via email, send a message with subject or body 'help' to<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-request@lists.freedeskto=
p.org<br>
<br>
You can reach the person managing the list at<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx-owner@lists.freedesktop.=
org<br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of amd-gfx digest...&quot;<br>
<br>
<br>
Today's Topics:<br>
<br>
&nbsp;&nbsp; 1. Re: [PATCH 1/5] Revert &quot;drm/amdgpu: re-enable SPM upda=
tes in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the the IB path&quot; (sashiko-bot@kernel.or=
g)<br>
&nbsp;&nbsp; 2. Re: [PATCH 4/5] drm/amdgpu/gfx9.4.3: program the RLC SPM in=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC resume (sashiko-bot@kernel.org)<br>
&nbsp;&nbsp; 3. Re: [PATCH 5/5] drm/amdgpu: bring back the ring parameter f=
or<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_spm_vmid() (sashiko-bot@kernel.org)<b=
r>
&nbsp;&nbsp; 4. [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC resume (Alex Deucher)<br>
&nbsp;&nbsp; 5. [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1 (Kent Ru=
ssell)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Mon, 16 Nov 2026 17:08:47 +0000<br>
From: sashiko-bot@kernel.org<br>
To: &quot;Alex Deucher&quot; &lt;alexander.deucher@amd.com&gt;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
Subject: Re: [PATCH 1/5] Revert &quot;drm/amdgpu: re-enable SPM updates in<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the the IB path&quot;<br>
Message-ID: &lt;sashiko-outbox-217409@kernel.org&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
Thank you for your contribution! Sashiko AI review found 1 potential<br>
issue to consider:<br>
- [Low] drm/amdgpu: missing Fixes trailer for reverted commit<br>
&nbsp; d44428868e5b<br>
--<br>
<br>
commit 36fa0c29e9f1b1b0ebcda0c9f28cb357bd14196e<br>
Author: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt; Revert &quot;drm/amdgpu: re-enable SPM updates in the the IB path&quot=
;<br>
&gt;<br>
&gt; This reverts commit d44428868e5b9f97c6216eee1b4f82aec7a6e8d2.<br>
&gt;<br>
&gt; This causes flakiness in gfx11 CI tests.&nbsp; Revert.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
[Severity: Low]<br>
Since commit d44428868e5b (&quot;drm/amdgpu: re-enable SPM updates in the t=
he<br>
IB path&quot;) carries its own Fixes: tag, should this revert include:<br>
<br>
&nbsp; Fixes: d44428868e5b (&quot;drm/amdgpu: re-enable SPM updates in the =
the IB path&quot;)<br>
<br>
so stable and backport trees do not pick up the original commit without<br>
this revert?<br>
<br>
--<br>
Sashiko AI review ? <a href=3D"https://sashiko.dev/#/patchset/2026111616571=
3.1945549-1-alexander.deucher@amd.com?part=3D1" id=3D"OWA9122be93-fcc6-cb11=
-acb5-5b4af5d815bb" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://sashiko.dev/#/patchset/20261116165713.1945549-1-alexander.deucher@a=
md.com?part=3D1</a><br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Mon, 16 Nov 2026 17:20:11 +0000<br>
From: sashiko-bot@kernel.org<br>
To: &quot;Alex Deucher&quot; &lt;alexander.deucher@amd.com&gt;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
Subject: Re: [PATCH 4/5] drm/amdgpu/gfx9.4.3: program the RLC SPM in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC resume<br>
Message-ID: &lt;sashiko-outbox-217426@kernel.org&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
Thank you for your contribution! Sashiko AI review found 2 potential<br>
issues to consider:<br>
- [High] drm/amdgpu: gfx_v9_4_3_xcc_rlc_resume() passes 0 instead of<br>
&nbsp; xcc_id<br>
- [Medium] drm/amdgpu: moving update_spm_vmid() to<br>
&nbsp; gfx_v9_4_3_xcc_rlc_resume() skips VFs<br>
--<br>
<br>
commit 754d99a96da547c9e401d40cfbeb309d0d3aa36f<br>
Author: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
drm/amdgpu/gfx9.4.3: program the RLC SPM in RLC resume<br>
<br>
This commit moves the RLC SPM VMID programming from gfx_v9_4_3_rlc_init()<b=
r>
to gfx_v9_4_3_xcc_rlc_resume() so that the register is reprogrammed after<b=
r>
suspend/resume and GPU reset.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; index da031caa4e9e6..151336e6094f7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; @@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctr=
l(struct amdgpu_device *adev)<br>
&gt;&nbsp;<br>
&gt;&nbsp; static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vm=
id)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, adev-&gt;vm_manager=
.spm_vmid);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; @@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amd=
gpu_device *adev, int xcc_id)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_xcc_init_pg(adev,=
 xcc_id);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_mod=
e(adev, xcc_id);<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vm=
id)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, adev-&gt;vm_manager=
.spm_vmid);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
<br>
[Severity: High]<br>
Should update_spm_vmid() pass xcc_id instead of 0 here?<br>
<br>
gfx_v9_4_3_rlc_resume() and gfx_v9_4_3_xcp_resume() call<br>
gfx_v9_4_3_xcc_rlc_resume() for each XCC instance, and<br>
gfx_v9_4_3_update_spm_vmid() uses the instance argument with<br>
GET_INST(GC, inst) to select which XCC's regRLC_SPM_MC_CNTL register to<br>
write.&nbsp; Passing 0 programs XCC 0 on every iteration and leaves<br>
regRLC_SPM_MC_CNTL on all other XCCs at its hardware reset default of<br>
VMID 0.<br>
<br>
[Severity: Medium]<br>
Does moving update_spm_vmid() into gfx_v9_4_3_xcc_rlc_resume() skip SPM<br>
VMID initialization on SR-IOV VFs?<br>
<br>
Both callers of gfx_v9_4_3_xcc_rlc_resume() (gfx_v9_4_3_rlc_resume() and<br=
>
gfx_v9_4_3_xcp_resume()) skip calling it when amdgpu_sriov_vf(adev) is<br>
true:<br>
<br>
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:gfx_v9_4_3_rlc_resume() {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_xcc =3D NUM_XCC(adev-&gt;gfx=
.xcc_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_xcc; i+=
+) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; r =3D gfx_v9_4_3_xcc_rlc_resume(adev, i);<br>
&nbsp;&nbsp;&nbsp; ...<br>
}<br>
<br>
Unlike gfx_v9_4_3_rlc_init(), which ran during sw_init on VFs as well,<br>
gfx_v9_4_3_update_spm_vmid() is no longer reached on SR-IOV VFs, leaving<br=
>
regRLC_SPM_MC_CNTL unprogrammed in SR-IOV one-VF mode despite the<br>
amdgpu_sriov_is_pp_one_vf(adev) handling in gfx_v9_4_3_update_spm_vmid().<b=
r>
<br>
--<br>
Sashiko AI review ? <a href=3D"https://sashiko.dev/#/patchset/2026111616571=
3.1945549-1-alexander.deucher@amd.com?part=3D4" id=3D"OWA905e176d-1a8a-f608=
-6a0e-e45a8c61fe05" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://sashiko.dev/#/patchset/20261116165713.1945549-1-alexander.deucher@a=
md.com?part=3D4</a><br>
<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Mon, 16 Nov 2026 17:26:33 +0000<br>
From: sashiko-bot@kernel.org<br>
To: &quot;Alex Deucher&quot; &lt;alexander.deucher@amd.com&gt;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amd-gfx@lists.freedesktop.org<br=
>
Subject: Re: [PATCH 5/5] drm/amdgpu: bring back the ring parameter for<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_spm_vmid()<br>
Message-ID: &lt;sashiko-outbox-217433@kernel.org&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
Thank you for your contribution! Sashiko AI review found 3 potential<br>
issues to consider:<br>
- [High] drm/amdgpu: hardcoded XCC 0 in gfx_v9_4_3_xcc_rlc_resume()<br>
&nbsp; skips XCCs 1..N-1<br>
- [Medium] drm/amdgpu: gfx9 compute emit_frame_size exceeds max_dw in<br>
&nbsp; amdgpu_ring_init()<br>
- [Medium] drm/amdgpu: update_spm_vmid() skipped on SR-IOV VFs in<br>
&nbsp; gfx_v8_0 and gfx_v9_4_3<br>
--<br>
<br>
commit 08b45306962b59cde3c232193cc26534f308aaa2<br>
Author: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
drm/amdgpu: bring back the ring parameter for update_spm_vmid()<br>
<br>
This commit restores the ring parameter to update_spm_vmid() so that GFX9,<=
br>
GFX10, GFX11, and GFX12.0 emit the SPM VMID update on the ring during IB<br=
>
scheduling while skipping MMIO updates when a ring is provided.<br>
<br>
[ ... ]<br>
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index df935827b002a..e818280139791 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -4084,7 +4084,8 @@ static int gfx_v8_0_rlc_resume(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&=
gt;update_spm_vmid)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, adev-&gt;vm_manager=
.spm_vmid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_m=
anager.spm_vmid);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt; @@ -5483,10 +5484,13 @@ static void gfx_v8_0_unset_safe_mode(struct am=
dgpu_device *adev, int xcc_id)<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp; static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev,=
 int xcc_id,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned int vmid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; struct amdgpu_ring *ring, unsigned vmid)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ring)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_off_ctrl(adev, fa=
lse);<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_is_pp_one_v=
f(adev))<br>
<br>
[Severity: Medium]<br>
Does returning early when ring is non-NULL leave mmRLC_SPM_VMID unprogramme=
d<br>
on SR-IOV VFs in one-VF mode?<br>
<br>
gfx_v8_0_rlc_resume() returns early when amdgpu_sriov_vf(adev) is true befo=
re<br>
reaching the update_spm_vmid(adev, 0, NULL, ...) call:<br>
<br>
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:gfx_v8_0_rlc_resume() {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gfx_v8_0_init_csb(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; ...<br>
}<br>
<br>
With amdgpu_ib_schedule() passing a non-NULL ring, gfx_v8_0_update_spm_vmid=
()<br>
now returns before reaching the amdgpu_sriov_is_pp_one_vf(adev) branch, so<=
br>
mmRLC_SPM_VMID is never programmed on SR-IOV VFs.&nbsp; The same issue affe=
cts<br>
gfx_v9_4_3_update_spm_vmid(), because both gfx_v9_4_3_rlc_resume() and<br>
gfx_v9_4_3_xcp_resume() skip calling gfx_v9_4_3_xcc_rlc_resume() when<br>
amdgpu_sriov_vf(adev) is true.<br>
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index 2e2673a6dbbf5..be45c10b6f579 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
<br>
[ ... ]<br>
<br>
&gt; @@ -7663,6 +7675,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_r=
ing_funcs_compute =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr =3D gfx_v9_0_ring_=
get_wptr_compute,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wptr =3D gfx_v9_0_ring_=
set_wptr_compute,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_frame_size =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 5 + /* update_spm_vmid */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 20 + /* gfx_v9_0_ring_emit_gds_switch */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 7 + /* gfx_v9_0_ring_emit_hdp_flush */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 5 + /* hdp invalidate */<br>
<br>
[Severity: Medium]<br>
Does adding 5 dwords here trigger WARN_ON(max_ibs_dw &gt; max_dw) in<br>
amdgpu_ring_init() for every GFX9 compute ring?<br>
<br>
This increases gfx_v9_0_ring_funcs_compute.emit_frame_size from 145 to 150.=
<br>
In amdgpu_ring_init(), max_ibs_dw is 150 + 125 * 7 =3D 1025, which rounds u=
p to<br>
1280 with align_mask (0xff), exceeding the max_dw of 1024 passed by<br>
gfx_v9_0_compute_ring_init().<br>
<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; index 151336e6094f7..f28ffe8a5ac55 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
&gt; @@ -1586,7 +1586,7 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdg=
pu_device *adev, int xcc_id)<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&=
gt;update_spm_vmid)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, adev-&gt;vm_manager=
.spm_vmid);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, NULL, adev-&gt;vm_m=
anager.spm_vmid);<br>
&gt;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; @@ -1609,10 +1609,13 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu=
_device *adev)<br>
&gt;&nbsp; }<br>
&gt;&nbsp;<br>
&gt;&nbsp; static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *ade=
v,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int inst, unsigned int vmid)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int inst, struct amdgpu_ring *ring, unsig=
ned int vmid)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg, pre_data, data;<br>
&gt;&nbsp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ring)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(GC,=
 GET_INST(GC, inst), regRLC_SPM_MC_CNTL);<br>
<br>
[Severity: High]<br>
Should gfx_v9_4_3_xcc_rlc_resume() pass xcc_id instead of 0 to<br>
update_spm_vmid()?<br>
<br>
Previously, amdgpu_ib_schedule() called update_spm_vmid() with ring-&gt;xcc=
_id on<br>
each IB submission, programming regRLC_SPM_MC_CNTL on all XCCs.&nbsp; Now t=
hat<br>
gfx_v9_4_3_update_spm_vmid() returns early when ring is non-NULL,<br>
gfx_v9_4_3_xcc_rlc_resume() is the only caller that programs the register, =
and<br>
passing hardcoded 0 leaves XCCs 1..num_xcc-1 at their hardware reset value =
of<br>
VMID 0 (the kernel VMID).<br>
<br>
--<br>
Sashiko AI review ? <a href=3D"https://sashiko.dev/#/patchset/2026111616571=
3.1945549-1-alexander.deucher@amd.com?part=3D5" id=3D"OWAa291d8ae-0093-900c=
-44c0-f87231b75bda" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://sashiko.dev/#/patchset/20261116165713.1945549-1-alexander.deucher@a=
md.com?part=3D5</a><br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Mon, 16 Nov 2026 14:10:22 -0500<br>
From: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Subject: [PATCH 4/5 v2] drm/amdgpu/gfx9.4.3: program the RLC SPM in<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RLC resume<br>
Message-ID: &lt;20261116191022.1955106-1-alexander.deucher@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
The register needs to be reprogrammed after a suspend and resume<br>
or a GPU reset so program it in rlc_resume rather than rlc_init.<br>
<br>
v2: pass xcc_id when calling<br>
<br>
Fixes: 7c0f7ee00c7d (&quot;drm/amdgpu: add gc v9_4_3 rlc_funcs implementati=
on&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;</div>
<div style=3D"font-size: 11pt;"><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----<br>
&nbsp;1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c<br>
index da031caa4e9e6..7b8ff043c99ec 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c<br>
@@ -1395,10 +1395,6 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(str=
uct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;update=
_spm_vmid)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0, adev-&gt;vm_=
manager.spm_vmid);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1588,6 +1584,10 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_d=
evice *adev, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_4_3_xcc_init_pg(ade=
v, xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_m=
ode(adev, xcc_id);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-&gt;update=
_spm_vmid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, xcc_id, adev-&g=
t;vm_manager.spm_vmid);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
--<br>
2.56.1<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Message: 5<br>
Date: Mon, 16 Nov 2026 14:11:41 -0500<br>
From: Kent Russell &lt;kent.russell@amd.com&gt;<br>
To: &lt;amd-gfx@lists.freedesktop.org&gt;<br>
Cc: &lt;jay.cornwall@amd.com&gt;, Kent Russell &lt;kent.russell@amd.com&gt;=
<br>
Subject: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1<br>
Message-ID: &lt;20261116191141.145348-1-kent.russell@amd.com&gt;<br>
Content-Type: text/plain<br>
<br>
This feature cannot be properly supported, so disable it both on the<br>
amdgpu side and the amdkfd side.<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 7 +++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp; 5 ++---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 12 ++++++++++++<br>
&nbsp;.../amdkfd/kfd_device_queue_manager_v12_1.c&nbsp;&nbsp;&nbsp; | 18 ++=
++--------------<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp; 7 +++++++<br>
&nbsp;5 files changed, 32 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c<br>
index 08d3ff61edcc..d0ede277aa85 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c<br>
@@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *ad=
ev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc-&gt;noretry =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc-&gt;noretry =3D (amdgpu_noretry =3D=3D -1) ? nore=
try_default : amdgpu_noretry;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XNACK cannot be enabled on GFX12.1=
, so keep noretry=3D1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gc_ver =3D=3D IP_VERSION(12, 1, 0=
)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_noretry =3D=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&g=
t;dev, &quot;Unable to set noretry =3D 0 on GFX12.1. Keeping noretry =3D 1&=
quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gmc-&gt;noretry =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hu=
b_type,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c<br>
index 1f57d0fa2c04..034cc3fd07f3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c<br>
@@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_=
device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 sh_mem_config =3D DEFA=
ULT_SH_MEM_CONFIG;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GC 12.1.0 A0 requires RETRY_DISABL=
E in SH_MEM_CONFIG. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (SOC_V1_0_DIE_REV_XCD(adev-&gt;rev=
_id) =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sh_mem_config |=3D 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISABLE__SHIF=
T;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XNACK cannot be enabled for GFX12.=
1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sh_mem_config |=3D 1 &lt;&lt; SH_MEM_=
CONFIG__RETRY_DISABLE__SHIFT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sh_mem_config;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 3d2136adb62b..3b62b9e5ecda 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *file=
p,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;mute=
x);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;xnack_enabled=
 &gt;=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int i;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!list_empty(&amp;p-&gt;pqm.queues)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_de=
bug(&quot;Process has user queues running\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 -EBUSY;<br>
@@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *fil=
ep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
out_unlock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* XNACK cannot be enabled for gfx12.1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; p-&gt;n_pdds; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node =
*dev =3D p-&gt;pdds[i]-&gt;dev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KFD_GC_VERSI=
ON(dev) =3D=3D IP_VERSION(12, 1, 0)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EPERM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D svm_range_switch_xnack_reserve_mem(p, args-&gt;=
xnack_enabled);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; args-&gt;xnack_enabled =3D p-&gt;xnack_enabled;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/=
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c<br>
index 525989371378..63ba13a60b98 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c<br>
@@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *=
dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device =
*pdd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dqm-&gt;dev-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vmhub *hub =
=3D &amp;adev-&gt;vmhub[AMDGPU_GFXHUB(0)];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool xnack_enabled;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd =3D qpd_to_pdd(qpd);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vm_cntx_cntl =3D h=
ub-&gt;vm_cntx_cntl;<br>
@@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager=
 *dqm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_ape1_base =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnack_enabled =3D KFD_SUPPORT_XNACK_P=
ER_PROCESS(dqm-&gt;dev) ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd-&gt;process-=
&gt;xnack_enabled :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !pdd-&gt;dev-&gt=
;kfd-&gt;noretry;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xnack_enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;sh_mem_config |=3D 1 &lt;&lt; SH_MEM_CONFIG__RETRY_DISAB=
LE__SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;vm_cntx_cntl &amp;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~(1 &lt;&lt; GCV=
M_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;sh_mem_config &amp;=3D ~(1 &lt;&lt; SH_MEM_CONFIG__RETRY=
_DISABLE__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qpd-&gt;vm_cntx_cntl |=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; GCVM=
_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* XNACK cannot be enabled for gfx12.=
1 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_config |=3D 1 &lt;&lt;=
 SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;vm_cntx_cntl &amp;=3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ~(1 &lt;&lt; GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAG=
E_FAULT__SHIFT);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;sh_mem_bases =3D c=
ompute_sh_mem_bases_64bit(pdd);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index 546721b4d59a..059e22cd7f1a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, b=
ool supported)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_GC_VERSION(dev) &lt; IP_V=
ERSION(12, 1, 0))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* XNACK cannot be enabled on GFX12.1 . While dev-&gt;kfd-&gt;no=
retry<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * should propagate this requirement, adding it explicitly =
here<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * will help cover any possible future reworks<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(12, 1, 0))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br=
>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (dev-&gt;kfd-&gt;noretry)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
--<br>
2.43.0<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"OW=
A0e3fda6a-6c64-5e93-37ee-3fbd31a447f9" class=3D"OWAAutoLink" data-auth=3D"N=
otApplicable">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br=
>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 126, Issue 488<br>
*****************************************</div>
</body>
</html>

--_000_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_--

--_004_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=528;
	creation-date="Mon, 16 Nov 2026 19:52:42 GMT";
	modification-date="Mon, 16 Nov 2026 19:52:42 GMT"
Content-ID: <b9da4edc-958a-419d-b902-61987424214e>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAcpJREFUOE9j
ZAABr6aJDHqhuQwMDIxgPrHg19d3DLP91Bk+P3sD08IIN2x1hjPDy7NXiDWL4T8nM0NA33wGWRMP
hg5NJgYGhv8gvYwMFdf/MYAMu3twP9GGISssv/qLYVdzMsP5FYthBv5nmO2pyfDzzVuyDEw/eJ3h
xNyJDEenNSMMJMskJE2Hp9YxHJ2CZOBUM1GGz5/hAUuS+UVnXjOcXDCJygbOm4TqZUpcGDJjJcPz
S1eoYyAvrzDD58/vGRgY/iHSYcX1/wykupBXWpghe89reEbY0RjNcGHFMkQsk2pgwYkXDBz84iiR
16EJzmWghE26C8uv/mZgZGJBM5AZ5HXyDPRo7GMwCCuEG/jj40uGCRYS5LsQpNM6q4TBOLqE4emF
gwxrs8NRI2WynSTD19cvSErQOBQzMhSdecvw8vophqWxngQNBCWTrBMvMMIPpnF7dQQjA6+UCEP2
3tcM//7+Zvjx8QNOQydZizFk7bvNwCepgs9iWIHKyGAYEcPALaQEUQwq3mBplQmi5siUBoa0bRcZ
hBT18Bj4n7QSWlhGmiF19xOcBh6aVEyagSCTQEEUNf8Ag6CcFjyn/Pz8hmF9cQjDg8MHAaiKxp0e
iZJ4AAAAAElFTkSuQmCC

--_004_DSVPR12MB449095DB25606D7FB40DB17A26817C2DSVPR12MB449095_--
