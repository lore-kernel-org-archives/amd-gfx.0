Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE616C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 20:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6001610E6CD;
	Wed, 10 Jul 2024 20:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VclMk11E";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188D710E6CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHUGJe7k8HeEyCETPFNClcWei90AGCWCUI42Av/ZrZVsx6wOAD6JCZsU5JEcZw7EV/S4BYAfVtq0VcBWtDySp8mi85qzKq+hLvfY0Act5hzLpW+3200w3XkC1wyci1ZqsJZ+uzWf1985yWHG/TLn6HAxbF9+hRzu8xWd1RdzF+if433MSDLrPT5Qot75O3O9AUBpiIKOkdd4jyqS/DzPZ+PxAxamSqtGBPa9DoGpL8ZJqYAUalRrTqLwWbdXyG5Qm/3sCJ3iYplIWh/lkBShSdEQz6CW0xLzTRIpb6TVD3p65vFShxz+oyHTfpt3M/rO7oFSsvp7tJtnzzgMIUF6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RBeFAtKSviVe727s95bG9VY9bkfAaA0oESCeAc1t2M=;
 b=JBs8c4NyCteDR6kDPXD1+shRDh9zfRp3XPt9Ha9dsmuZ1l75vPIPAEZNy5T105tM8uY2giBNk+fgM6SCC5+Ex5d7O/wxMZs6TLfHqY3ETDJGOwnxZAykVGz+9gDwyNBprG04LOzoJWAIzUO9eRT/w35CAvX5Gm6OrBNw1mFuKp+rNkvybIzl1hNLGPjejuiP7OUT5StIX3TsqZoqfq6R22/IUkfQE+jvglLPbdEEZtv0dgBhD7OlB854oh2FGnEDf7DghbMKugxfsYupRYRbTcx8ypv9wi8ZPKkVOmFwETwZO1LsHRvO04RlnurNb6ML8t8U67T6o8PaIPoNn2CQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RBeFAtKSviVe727s95bG9VY9bkfAaA0oESCeAc1t2M=;
 b=VclMk11E/ALPdgNO5+T5HwJXNgs/TPtqr2VXChiEUCQVuwKtD/TCmdA8323TfU6zA/CNKp75gb7D5rzQxhEBN1H1Z2w8CbSqJ0qEtrRNUsyCQ6aBo+6tL0n1fFig9yQrT+jvhTt43B+RDWIcNEvGpZ5JMxRNAgCtDSQ4Ahvw/0A=
Received: from IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 20:42:37 +0000
Received: from IA1PR12MB6185.namprd12.prod.outlook.com
 ([fe80::7f8b:9db1:39bc:1012]) by IA1PR12MB6185.namprd12.prod.outlook.com
 ([fe80::7f8b:9db1:39bc:1012%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 20:42:37 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Thread-Index: AQHa0wf9d59DvlT2hk6wruADpEe9trHwbCKA
Date: Wed, 10 Jul 2024 20:42:37 +0000
Message-ID: <IA1PR12MB6185E452A503EB434711826995A42@IA1PR12MB6185.namprd12.prod.outlook.com>
References: <20240710202952.188573-1-boyuan.zhang@amd.com>
 <20240710202952.188573-2-boyuan.zhang@amd.com>
In-Reply-To: <20240710202952.188573-2-boyuan.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1f031286-e2ca-436e-bb74-f376ab628c33;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-10T20:38:18Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6185:EE_|CH3PR12MB7499:EE_
x-ms-office365-filtering-correlation-id: 3d0c638f-71f6-4476-7d0d-08dca120d5c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gsvvWMEzF+USatCqwc1aDKgPrUc1sJgXuCmAHiBu3JvWOgctullw5CxV9Xf0?=
 =?us-ascii?Q?RLN6tF3uAZ3L2DuJSxD4Lbd+JQiKDquDIF89RFooOLiF/78dB/7cmDSR1UOS?=
 =?us-ascii?Q?YlYKv8nfww+4sShwCfCoa0x3lMs8awpecADqJ/OfgGON64nj6fOtGhHLICJ8?=
 =?us-ascii?Q?DV8W2UUYNuDz1LEnzkqJ+ZH3ZKWOw3GstrZEhAY5LSc4rSVs7DC73XsiL//B?=
 =?us-ascii?Q?9VRnMGSv2aHFlpsSr+wYlCZQ4DxK2jop2WvFpgiz0LpvatQMpV5snNmq8VVq?=
 =?us-ascii?Q?XqTxJxiqvMSVJdRJqrsjRPwjimw9p+iev0H2+l5qM9a1koAUmpfgLzB4Lof3?=
 =?us-ascii?Q?HGg27gJ8KQFO8IBh6so/3Y3LoIZyh0yXtXZ6ZdUYsdhRfNx2ZVSB/Hg+M690?=
 =?us-ascii?Q?UCFIp0xjMCNYjKfJdhEFPw7TAxaQhhC1ysSVBQ4mTS1/a+imp5aIRVPL0J1s?=
 =?us-ascii?Q?Q94IFpVdbhoFVwFyB/QCp/Bk+1WPD2dvbQajKhlypLOYmNRU4TC5fOc9IXLe?=
 =?us-ascii?Q?ltncypTfh3SXt0DqT3reU8Iz1l4gPCKUTZPJMms8UkDxJnvawSQws3EtTHZF?=
 =?us-ascii?Q?P+w3/5skR5Wt5lEPTeG2mvbPqqaUFfUw6YVIJWLbQoG75hvitz3VTGaccxmi?=
 =?us-ascii?Q?LFMNqGVkGJWrHUqckiADxev9xSXpltj3mIyJgbGzD4wCBXDvOqKoW/cD/yxc?=
 =?us-ascii?Q?bkK6qRG0aeedZTYo66r2kbtHcYhV8KAepgPGVi+Hz9XE3DEaPLremCFbkzVN?=
 =?us-ascii?Q?vxWNZOqImi5MN/CuG9kvkK0/Fw1dZh5DLt1o1Lt86LmqZbfg3TVjvmRuFpLu?=
 =?us-ascii?Q?NuW+4xn8pd6UTRw5uJVkZPAbKKbIR3HbNCR/aXwWkO0LuGUU+vLbWjQ9L8Uz?=
 =?us-ascii?Q?tK38Wb28leU+GU6GbzjQ/5i3EHo2PAYLeHyUIqJpacpGI5v2EeQzJiCGdTRn?=
 =?us-ascii?Q?ZxHp4+Il3UXQ3v+OKt6schfK6riAaJZbBOjUFFXQ2IbnHKTVvnuDxCmzIPZi?=
 =?us-ascii?Q?dl/F2Q7Hmg3hmYSBWmp7nTBBQtqTs4PeJoqwsklG95PByiCTcHKee/BIdfIe?=
 =?us-ascii?Q?GuZmFdruPDkntblWWt3umWT+dkeFvliJIVHz9tlb/n6Qn2dSlMNa68YUkgYv?=
 =?us-ascii?Q?PHmHp72OnKqFTFlKmyC4sI+cgZP6SslhBy4qSvH+gNNpAqI5B1+s7U+pf7Y6?=
 =?us-ascii?Q?BZLoib51vUPj5rdfvLk4T0PSmI8Fk9oz9JyJNpD8XZO1x83GfESqzt4kuMOm?=
 =?us-ascii?Q?j957pW+SxyYC2zTiql6daJAPQYpP+12vigU0+iCaAQ6Nq99MQV9DOlrwrd/Y?=
 =?us-ascii?Q?vX3clCkNx4RlRDaa1qlN9GhPOvsE4EvbsaF8CHAhNaostAlAX5ms0Y64erOF?=
 =?us-ascii?Q?H/3SUQMR6pRDO18WZFCLbPNN/Yz7xAV1APzZaSOSatXIWNEsig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6185.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y6WY6XzDBB4VrLgUlp1cIlaQ/aD4gd2YSIKunqSEn6acBncHTjAantsY1evx?=
 =?us-ascii?Q?e7r3o+D3cHFQ45tESaZXFNGpHi4OB6PytU3Te2sjcMsMmF4iSAhzeslURZ5h?=
 =?us-ascii?Q?lh369HBDnlzVJVWdzsi69rsk0tzumLwvXykpoYWG8f64aGgGH6fwtNFp597e?=
 =?us-ascii?Q?qnOX6JKgKxQsqQLXnF1SkI1aIIX0fd6WTrcPtYadtj/y80j6O1HvX92hg1dJ?=
 =?us-ascii?Q?I++iQgSnNTzzdkFz8HheS8+8e9K7vAWMyt1lStvMkv72SYvymYLdNh46LjyB?=
 =?us-ascii?Q?lmvTd04M7hxeR1FJhZ12ekhrSMWmhEX78lq65k19YW33/Ewb1OPwbDgvst4Y?=
 =?us-ascii?Q?9dnCXsWyCx3whG70LOsONl/0pg5IfVJuTxO8O2Rs7/bq12HJAsdaVioVKE9T?=
 =?us-ascii?Q?DIrTd3yidoVXP/9yZaEJhmJ87T1YiI/wzk2AhcVc3y6rTPOzyxbg5DvkTjFS?=
 =?us-ascii?Q?gMGDgsW/SD5jPEQ/RB59jF65yKfWlTbCaKSrzlQ+lFmHq1s7tiCodTgyOaSd?=
 =?us-ascii?Q?EaomNyM9G+CRL07CRQRpNA4JdO5h0Fhwbi9KhfKPri9PwHti0kMxuNAY64at?=
 =?us-ascii?Q?0XkSEwqjOMX2+VoNIGM0YpWkIHUk5AL7nv5Yk2UAa90008IZ2wLwRdoSJbcm?=
 =?us-ascii?Q?MooppfT+nh2u6hDQkER/+j3UgeQHCLLDLvg55GKnu4dzLo+mihJ2UKlCb6dX?=
 =?us-ascii?Q?lQGvYOv7MLfc4p6pOKq5o46akfJa/gcUI+U5LZAwBU+Fxigl1WbV0462yWk6?=
 =?us-ascii?Q?CiPD5Tg6I25cKQ3gt/iV2dPC+krqBS0u2WA4gc0YoiTVSBuJmZ4XzdgA3EOB?=
 =?us-ascii?Q?VpNW6Z2YbOzCZxsQEI1tuGVIcJjvdqDiGqymizk4li701HPwypQDuo05skxz?=
 =?us-ascii?Q?QFLh8YKg2od/kA8CRALHfw2P/Hs0p8nGnqXgSNVMCu3wI+8vEuPT8TmcvKCS?=
 =?us-ascii?Q?xxFWyNsQ6cNtcl8lvmNchy9i0z6fcbSx+dNlmJMXnug8trDlS2Fb1JyqWcM1?=
 =?us-ascii?Q?3pdvyu94f/pH1YS9K/J4264W8wC859MqC4YfoAKhfXjuIiRjmRD88fEjg4NN?=
 =?us-ascii?Q?vD77J+qlc+1nBIp8i5EgaoIu+Be30VhwW2WdZM2ZWCCQho0aJb49r0W6TqX1?=
 =?us-ascii?Q?EfSBMibeBf4CfLCWu6ro06pzHR9iW3LPxCPdc7zxYTAg7uXmyutvDT4ARvgy?=
 =?us-ascii?Q?NaDgf4agObZkimuf91/kMYwVgOesryH9inDN6NDNG3rjkeGmYNyTZvqAGkN7?=
 =?us-ascii?Q?npWJ2lmLi1lletTGdqqgcOaPYudmrCuKDCpRB/HLNzsA9afvqUPZMpo5dWZd?=
 =?us-ascii?Q?zLmD1/pWH+43LMn428nnXP01YISt/2CKRo/hR09d1up9o2l6w/ptFPEbQac7?=
 =?us-ascii?Q?GZgzE4cTtIP7++e2owMJhas+mKBA4sJucUKIq3hB/GyXTKKf8Q3mb9kv9QYh?=
 =?us-ascii?Q?Rz/Yzk5wBJFm23Zn2NVho/Qjsg++BBva1fifsQ6TRf1CK9wLwq5AZFilZFM5?=
 =?us-ascii?Q?siV8pHjqkK60HoLInIEy6MBASft+yNwi/kfH5fvYy4GLO+eEdv5JUmv3x4ud?=
 =?us-ascii?Q?Kenujca10VzcKGzYg+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6185.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c638f-71f6-4476-7d0d-08dca120d5c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 20:42:37.6407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYSXrLs0Zhj9QGIvdXwreAB5Q2CW7uHhtkvWFLzinS3YkXfiEWnBFiAGNncPSqo0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
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

Just change the commit messages from "For previous generations" to " For VC=
N3 and before" to be more specific.

With that all patches are
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of boyuan.z=
hang@amd.com
Sent: Wednesday, July 10, 2024 4:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Boyuan <Boyuan.Zhang@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: not pause dpg for unified queue

From: Boyuan Zhang <boyuan.zhang@amd.com>

For unified queue, DPG pause for encoding is done inside VCN firmware, so t=
here is no need to pause dpg based on ring type in kernel.

For previous generations, pausing DPG for encoding in kernel is still neede=
d.

v2: add more comments

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index f59e81be885d..00f3ac5f4572 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -412,7 +412,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_st=
ruct *work)
                for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
                        fence[j] +=3D amdgpu_fence_count_emitted(&adev->vcn=
.inst[j].ring_enc[i]);

-               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
+               /* Only set DPG pause for VCN3 or below, VCN4 and above wil=
l be handled by FW */
+               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+                   !adev->vcn.using_unified_queue) {
                        struct dpg_pause_state new_state;

                        if (fence[j] ||
@@ -458,7 +460,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring=
)
        amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
               AMD_PG_STATE_UNGATE);

-       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)    {
+       /* Only set DPG pause for VCN3 or below, VCN4 and above will be han=
dled by FW */
+       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+           !adev->vcn.using_unified_queue) {
                struct dpg_pause_state new_state;

                if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC) { @@=
 -484,8 +488,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)

 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)  {
+       struct amdgpu_device *adev =3D ring->adev;
+
+       /* Only set DPG pause for VCN3 or below, VCN4 and above will be
+handled by FW */
        if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-               ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC)
+           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC &&
+           !adev->vcn.using_unified_queue)
                atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submissi=
on_cnt);

        atomic_dec(&ring->adev->vcn.total_submission_cnt);
--
2.34.1

