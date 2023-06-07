Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E61C7EE29
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 06:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F385D10E444;
	Wed,  7 Jun 2023 06:52:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1263810E44A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 06:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMiglJPXa6GayeH8RM2UB1YxhBvQjd4cBNm/eLcnYPqAaHbNmSuR/JHVs9UgL16zXDpUFU9NuRcg4CO5LKDvZD+aOitFFPnQO6P7Wb+76w7MVZ11l5Ia/a3hFKslTswIYekP9U+O/T+CQJlgP42n1MjOUTIZndfxSiDzdUphOsrhNyT08pNMyAJepEug/GlzMYXD+PV2+Ci15JO4x+fh2uL6LUxaPk/vOzJeypUl7PJP8wuLs8YcA8ivK8YIFQbGnjP/XGk+cJ+wBjqcJkUWl8RlXqiGvqpOR2uH9+Ciz73XFvRtZKhPf2ce5V9z6n9jlTWElpGYeyrXfo3H2rPjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CM7u+ppeuMIBWk7Eo9Es3hO9kHdlCU5L/c1lLUhFDs=;
 b=lgN4ZLiV33Los0c5/sit5OmSBazlqaOxVGqk2C/05d1MDC9I1vggH1cdbmLCIiiDYq58cSGEtcq/06g4KSN5IOKu5WiY3sHrp4MJeU8GZ3SGUKkCgGv4xoHV/syAGi1/wSP4Fb0NGELO82kkp+l5Je/wKVOpmzgNSc5fwpXrsiJns+/jledRdix6j0LaAPnfr7IerQI1w5J54VlizKpzexbeE38ktzrjgbOvkuXEuRATKvEr3Wq3WhtRxevPMBhQDBUiwSRBF1TyUTjpcIxl79LFm8T9VgWBK7ZBFt7SfvxVXlDmrCRtIk+han3zJDj/VN7XrMkhxVDA9vO0+lYO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CM7u+ppeuMIBWk7Eo9Es3hO9kHdlCU5L/c1lLUhFDs=;
 b=QTtw//oDpnAFLTnUr1gvtYdTzTMKZLM73dgJWS27c5pn9bqqnrnYblxnPI1vB8txwhveWHyXKR15GIqbopN6W148UkKd3Hm3UP1eotxHrqBc70tygDn05oOju8nWOIkOoxiAx/tMi3a9JFIn/su3O5IrYJB+F+yo9On5WR8cFh4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Wed, 7 Jun 2023 06:52:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 06:52:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH Review 6/6] drm/amdgpu: Set EEPROM ras info
Thread-Topic: [PATCH Review 6/6] drm/amdgpu: Set EEPROM ras info
Thread-Index: AQHZmQwZH6UEfDVE3USTXgk66Q0dU69+5xVw
Date: Wed, 7 Jun 2023 06:52:49 +0000
Message-ID: <BN9PR12MB52571A22A107913946AF1290FC53A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230607064814.27226-1-Stanley.Yang@amd.com>
 <20230607064814.27226-6-Stanley.Yang@amd.com>
In-Reply-To: <20230607064814.27226-6-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01fa1315-6093-4f27-b5e6-2188fad8aa9f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-07T06:52:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6663:EE_
x-ms-office365-filtering-correlation-id: 15e17335-7fb6-4b83-7e8e-08db6723cf30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRcGg9llEnFF07ref7YXV2J8zySzNasPPQnwtm0mxs2TKFx1UmbJ8QAdQ3KNOAwADyOTV2BSdDUMrs336qr51yxDxaFN2wkSbG59vIosCfac/4pHlvPCYFaTD6qbXDM/BRAmGlNgdJPbttgRnbUulDLwvi95V61k5zKZpon+jogD9usvs8kg62JWcvNxNQG50AmbIaJonTxrXRbmYu26T6u2XRvSGR2WDE0+2nuZ+tnoP8AkUhFZWJPIorTlT2ULCyy4O1l/AfzntfacVmHCRLgr43EJGpf21ec3phDbD+NAyBq7LHYDdQlt8hQNqawlVDajBGap3+R4YW+x6RDcQKKvvHub+ij/iQvotBAJDrenco/qTnzWB605XA8zsOpOuFr13XOa7Dy/+3KFM6MfLI2wSjZUE4U2vOWiT58rD9JzRDmluHcLH+/RQ233UItxJfi/B4hVBlWcnXlUa8BEuJLLobPI0DWeR6Ha76OWf/9qPHLTrtdfcwqlW0jB7Rw8lzuao179Yi5Xt1rwAn0LyCKznktsG0xuAhgwjVKNtUFcOOBjhEjOPb29zqWhEG8+OT9wWlA+EO/4aUvPMSIpS8E/uf72k/CPY5qdzv/VMQi+txQ0r9Fu1AI7962niumd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(83380400001)(478600001)(110136005)(33656002)(55016003)(8936002)(8676002)(64756008)(38070700005)(316002)(76116006)(4326008)(52536014)(66556008)(66476007)(66446008)(5660300002)(122000001)(38100700002)(6636002)(66946007)(41300700001)(86362001)(71200400001)(7696005)(2906002)(53546011)(186003)(6506007)(9686003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g5JSdE3Lc2EP3do8812nlmA36oe6Ls894uw+hrnKt1OeRhaLQJcSm1P8yEjm?=
 =?us-ascii?Q?Sh0xz0roDBxjhzCk+zuI8TH+bQzSCilJMYkeMLhAhRqa/eIF4cN8OCwJcVZx?=
 =?us-ascii?Q?dL/EL0IbvPYZAs1SxtWXa+tJvxe3eK/3gHgzhcHBUnjWcYlSjBEYDU575vwm?=
 =?us-ascii?Q?QbjwNdOGM61m0OoTHuzIeIxhWLd8JVFMibg1NoV3uhCOfqOdzT68zwoEBPag?=
 =?us-ascii?Q?BdzkbJEdptyb3QSLD7cYrtnvLSydMzCVr79gI3vTMz/PuwrHBal004W0IaBH?=
 =?us-ascii?Q?czQU8j4HZ5YoyAY1r+iL6uDb+cCDG4Fd09Iq8YzCU5U3zLrOR2Y91M0qrziQ?=
 =?us-ascii?Q?BXdrPS4hZgRsgIeqkrriNk8eX9rany+hY/FFRQ+3RCN3kIsy+kYQR4bbCStT?=
 =?us-ascii?Q?TQvv1VY1LMu9Mg0SmPwu6x2KaZHk61qxP1MJxA4l16jSzZGUmwNlnWRqFDNC?=
 =?us-ascii?Q?2HHlMYhE32QbB+ii5dVZl66algHwKq+jaCVtFXcNrGbHW+KzglDnzzxNCmAS?=
 =?us-ascii?Q?lQ7cL/DV//g9kZqEarRGyAjykb1N2P0GKuCRtnRRsQXHCDdeV44lIplJc+F3?=
 =?us-ascii?Q?26lVMsvjXdV0f2Ex94KdagIB9vpb6L5MTMbFg0uSpqtLdGYGPe6BQgmLP9kU?=
 =?us-ascii?Q?lSoScfF1QIL3dwS7SIGNs6O9B0pCRbO8G1V+SgJvGYhYMuBxhvsYpI5DJgcL?=
 =?us-ascii?Q?fSpbQafd1jyX921kVXwztbMJRXn7bfGLGwpWiQ+CPXD1od+P57Cq657JL7OJ?=
 =?us-ascii?Q?fKJFpUAReq77dBv5yA9q0OweCKxMSCqWl3qYia/Ygg7ZZnMsjd7S0RimtvJS?=
 =?us-ascii?Q?yNlS5AdlgKqBxobpA76PCFUvZ/8bSrCkoJz1a4zx0AoqQfPquHpfb70GdMXV?=
 =?us-ascii?Q?k2ilCiZX78NGOYZGeNbyBOBWNa8YKivIUptbTNaiQmDoNs+63CU5h0s2wLfW?=
 =?us-ascii?Q?ZZZLsTji/R2o6NyRDCAY/kscbb8NwofBfNmJjl476ufv2OHoH+63j5RXKri4?=
 =?us-ascii?Q?b9HHr9iqNro80MbtNyYpAosyBk+VZvign7znlXYBbZ2DNjH93d+zO290MO4r?=
 =?us-ascii?Q?KZj5EvH17ncQx0CSW5tnZ2jn6nYKmgPRFLURjQozMJU7O5dOqUMEx4hKeAOQ?=
 =?us-ascii?Q?75zsvrLRbRUUsPzxW2V6sAjbq/TrrfSPq1zLFjhmP/80rzRFuhtjSNm/4ibQ?=
 =?us-ascii?Q?fzfD2rNykR5Spyj/DsPgEQLQywVjl28DqQFqvMsnuNKesgmJUchoFWmnyTmx?=
 =?us-ascii?Q?WpMvqy8pKUvihUL+yMWvLkErG3/LG71LQ4qD6+hIjS2fosuqHSmWyKC9HvQW?=
 =?us-ascii?Q?45Ue7Jve6XfvKJZOGdZsslQng6FCtQI6QdINQe0SgQfD/Q+QB7F/Vp/RDBP9?=
 =?us-ascii?Q?R5ApMIXeqdtcmN2cC/tITYLUcJwpuXHbYex9BDggmCDb4dWk+5jOvuWnNHHR?=
 =?us-ascii?Q?6KYXAQjjKazjQBk9kIhY25+wGVZY2cMkuoeJChVTSBpxqmwMM3ILIbFo0w5P?=
 =?us-ascii?Q?0CCMZX/RGF+V8XCJMiBZcwmB5qr8KxQsNcTqKANn1NsGIv+aecB4dCJm/5qw?=
 =?us-ascii?Q?OjuLqlvVfVo0WyLXxaxCIIzEEWJhZ3eIvPrLI1mO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e17335-7fb6-4b83-7e8e-08db6723cf30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 06:52:50.0338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iz2hfkKm14JE7tCLXzZZ1S4e7AovNMGZzNl+2c3JX8nZOTTvMBoqgA1XDUhFRTkxRsZf7AN9dFzGf7HUsyUqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Wednesday, June 7, 2023 14:48
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Can=
dice <Candice.Li@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 6/6] drm/amdgpu: Set EEPROM ras info

Set EEPROM ras info: rma status, health percent and bad page threshold.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 24 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  5 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 9eceb3bc1058..c2e8f6491ac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -406,6 +406,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eep=
rom_control *control)  {
        struct amdgpu_device *adev =3D to_amdgpu_device(control);
        struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
+       struct amdgpu_ras_eeprom_table_ras_info *rai =3D &control->tbl_rai;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        u8 csum;
        int res;
@@ -423,6 +424,14 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_ee=
prom_control *control)
                hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
                hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
                                RAS_TABLE_V2_1_INFO_SIZE;
+               rai->rma_status =3D GPU_HEALTH_USABLE;
+               /**
+                * GPU health represented as a percentage.
+                * 0 means worst health, 100 means fully health.
+                */
+               rai->health_percent =3D 100;
+               /* ecc_page_threshold =3D 0 means disable bad page retireme=
nt */
+               rai->ecc_page_threshold =3D con->bad_page_cnt_threshold;
        } else {
                hdr->first_rec_offset =3D RAS_RECORD_START;
                hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE; @@ -712,6 +721,10 =
@@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *contro=
l)
                        "Saved bad pages %d reaches threshold value %d\n",
                        control->ras_num_recs, ras->bad_page_cnt_threshold)=
;
                control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
+               if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
+                       control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD;
+                       control->tbl_rai.health_percent =3D 0;
+               }
        }

        if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) @@ -749,6 +=
762,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control =
*control)
                goto Out;
        }

+       /**
+        * bad page records have been stored in eeprom,
+        * now calculate gpu health percent
+        */
+       if (amdgpu_bad_page_threshold !=3D 0 &&
+           control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
+           control->ras_num_recs < ras->bad_page_cnt_threshold)
+               control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_thr=
eshold -
+                                                  control->ras_num_recs) *=
 100) /
+                                                  ras->bad_page_cnt_thresh=
old;
+
        /* Recalc the checksum.
         */
        csum =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.h
index 3c5575c19bf8..6dfd667f3013 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -31,6 +31,11 @@

 struct amdgpu_device;

+enum amdgpu_ras_gpu_health_status {
+       GPU_HEALTH_USABLE =3D 0,
+       GPU_RETIRED__ECC_REACH_THRESHOLD =3D 2,
+};
+
 enum amdgpu_ras_eeprom_err_type {
        AMDGPU_RAS_EEPROM_ERR_NA,
        AMDGPU_RAS_EEPROM_ERR_RECOVERABLE,
--
2.17.1

