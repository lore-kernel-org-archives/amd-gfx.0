Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1D7CA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 02:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B00910E3BE;
	Mon, 12 Oct 2026 02:55:02 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01ACB10E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 02:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlPBacClA9x4f5UKlMnTbnpnrlAtSNoA1kCM4qGpGAsWKN8BSeQ+/PpAxC1j2aUFcl4/ZsmPUiN82FLoUEpDK8vx7ovzulZ1JMOl/zj1hhLap2ofDnHQKXQMOW2I5xteF2TskRJmW6RQ+WLWlTPTr/LpfMqGWqwZSpwk9Hp6PqZ2acwO4XfRtQRLfSfyhdUTviWbL9x6ISDcYjJU+8/RQIbMaS1aS2OF22Yjv/hDbpoxM5RTloIyua58rnQHLijcIj6CGmq26uDAhGalpaAmAicHr7pPu7JUJcA+AcB2IJ5tOvDkKnki891IUwychNuBnNc/6+x4tFYN7Q9RSPk98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xapxb2JNUjRnUmIZ+T5tH9FvXu8KJqlrJTHM08d916Y=;
 b=PYnI8FirPTNhuyS0KdSMoYYDYkpehD/cdGjJ+aE56ravTV93a+OwOA6i+ZESZehF1dNS1wYfDEDd1lulCMZSbcpuTABAbGuhT822gxcKcMtpKzk7QunZ9HptVgsH+p/elqPzDC9C8Hw4tSElNA04VuMjtSheJnL7z719M9fAsNfjWr6LlcVOwSiYXa79sn4VTwdsqbdk6kTtHYKv8QjObFPgYC5LmJnDN3V1NBvDyivIJd6buIPybzs4KIlcuzC7FmiGsi7A+jD2zQTGnwGLi/kVQd6G9ujs80W/rywJrcLrTrBAfMC723JWSDnR+A52i7+C+EMG4DuOqzHXqhbbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xapxb2JNUjRnUmIZ+T5tH9FvXu8KJqlrJTHM08d916Y=;
 b=RrJrmavjf7LEpnzgYuX56cf9icwDin55mjE1qoQXv42i2tjdcnI8y5ch4+9JGobUbsZn5QVpIubKp1XhxUipbrRMIBPvHnHj+e3OuDzmzKIbrpEK6ndlvgGV2u+QFvXhusXPH4JY4fLXQO5yAGXVMq3YA8FvXsgXUwyIoNJWosU=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 02:54:52 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:54:52 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: mark the current DPM clock level active
Thread-Topic: [PATCH] drm/amd/pm: mark the current DPM clock level active
Thread-Index: AQHdWejtU2fpKTnXHk+N2TYAx7nN/bb5Nj2A
Date: Mon, 12 Oct 2026 02:54:52 +0000
Message-ID: <MW4PR12MB6803E9CCDC422DD6D999F6618E9F2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20261012012748.3150968-1-kevin.wang@amd.com>
In-Reply-To: <20261012012748.3150968-1-kevin.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-12T02:54:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS4PR12MB9563:EE_
x-ms-office365-filtering-correlation-id: c304a092-74dc-4f3b-e75a-08df280c3068
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: Ig/ex0qjXCAKyr6pr2k4m4Yjl94A3bDmQKKaNH3xBlHjrL7BefOShXIhxmeI8Xv3VeqU40ZRkW9zCQTPw8/uRca4P8WslIAU5awfgtk6k8wMXXgZMZXjWa1s+9aGUTUYEAm2lJuB/lNfAXuMexXM495Ue8HoOCkkpHMSqTJE24Q4v7zbLHKoDfV9ShtSIBVe3Eyi/sA7h5yqvtJMH/NlPs/52NdI8Jn4h1oL3eWfEHY/0KTRhLwxIaHLL5YNAH13MdphYGqwdbaPoJWA+oASz3Zg7bLfP619sOFXtU9Vyl5sh53RkEKFtHLbVmKm3hW+TSFZ7bciY6/9WmIRu/F7x2xY9OhvfVZ3iQfOQ/j6R4D0FLl+SgJwSBJw0OlMUdHn3Q9SbF4zglJeDuz10VNWAnjZ1TBf5z3TY+PWgrjk6FpW6B/Ec0NH8hlOBU8d0mW7615yLJ6xnwrGJOoFlri6xGhoasksWqvrgDPtHzU7Rme94ZJuKBMBwD99iCtocEqAfhSySv1V8FtvtkulVndtW9B7snQ+ja4w83WKOa5wl4RnhHQ8+y18IsRgUrDzu3V2ULPVWD7QbnJYMbZ8sAI78fBTMhKGCHtqnH83OnH1jnUGWjvRJdGkCzJUEcrxOluhZHrVu1JlHSvLkzIQJWAFmlM26fsxHLPin7KGuGmHijz0zhkKY9txz43fpDOyPB06HDJcVooO/23z5+tsVtsH3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0odL3cddSjs4UyVvQYswYzVkmKTdQfdEWsipbIqVl9Z1JSDopJLJo060jrY7?=
 =?us-ascii?Q?qfkvQdxT/aPRXWzy+kpGhb0bicrERQxpqTQtlx9V7t/S60qnu4FHKN8FKi1J?=
 =?us-ascii?Q?Tx+e8W7WBYylgsjHITZ/VXRYAKaGyZDzemsDZmX4Q6ebvGq3HHOIb56ZVb1e?=
 =?us-ascii?Q?gT1yRrR3g03JGVlctthUr/QoFaxr3MYzStb6PzGCF0RsFZrBWer4mmGB3bZl?=
 =?us-ascii?Q?agqpjuFXSHGGGCSPev224vJdkRRvrsGYju9QP4r4MELemVtPo8purJcSk9n0?=
 =?us-ascii?Q?c+yyGVpej+BrzXNT991kS19nsx7zQ/g6RIHCc+bE6Vq+UTGSor7BCvj64SJN?=
 =?us-ascii?Q?SE9FXYHAUHMCIBKTr1LGM3vlLr26tvw/Ez6c95ADAO/TBycHEH/irBWMyvy1?=
 =?us-ascii?Q?AlorgNN9caMEfn5gx0yZW/6ohlfTF4I3i6I2h95sQamlxbwodlJJLg9FBeAc?=
 =?us-ascii?Q?YRT8hEa2ZTsm0fz/wx2umSvl6XrE7L7BcnKJYr3b+zhPNSwem1AIHxNbaeYP?=
 =?us-ascii?Q?FqADTgBVOEKYzmA2vI1aKVMq3Y3+tm4MYIpG3V4C6ArGIfZJ297jKtx8WYpa?=
 =?us-ascii?Q?X6eSyEp2+8mLL5tzE3xORLEBI7+Mw7S472eycPUjfg7WedwejLN8jOILu586?=
 =?us-ascii?Q?xC2tQEPnfcEJJIL6D/EzE1zg5qdbYAI3uruZ6IPG+klkCCtKN47ZV8vvH3TS?=
 =?us-ascii?Q?6T+zxT+EeBfBRLKADXc8W4+h2sDdw38X4Giadd8VgypuudVcjS+mqbVAK9OR?=
 =?us-ascii?Q?mqSEPjOHuGureehXR9HxEiVKLRTGXZ0/fEU1ki2l2hI/XUuW00uEGPBPTwcp?=
 =?us-ascii?Q?HVboY09wMjhLDYDL9gtleaZwWAIC7++d6z+1nMMis0eYGM2WekeZkCxFET7o?=
 =?us-ascii?Q?aWrzOuirRRgsV2KKfgJunfQGhDowBZFcSTXHPRnTu96DeQ8RObCjk8VlF1KF?=
 =?us-ascii?Q?6A4+A3FhibchVNqcoAvBxPCDO476XdSdcUGY8DbuMDaa3nuHR+f/ra+11zTp?=
 =?us-ascii?Q?cwTS+k1ZzGptvpKz2S7LAsj0oNihjpbc+/v5kSldMRzEGuWEXF7+/TamTUXw?=
 =?us-ascii?Q?HmiprBRa3HtMk/QexDsjWnS86iHM752nxc6Pqp2WENt+OocT+64OU3sJBkb8?=
 =?us-ascii?Q?SfJBUveLP47mZs1ZStiFXvniC4ljiQ8fH7Kc/fbiddbuapZJZ/CIIB1i+XgL?=
 =?us-ascii?Q?9G0wC3QRSuVUpZJ/bmo4dt+Xy+B9PENYr2pzbyyMcUwd4T6MAjtuDnpD9Vhc?=
 =?us-ascii?Q?ro+cW3E2wZ4wmmmP8I7KUKYC66NHaccsWqoZU7a9KkL9v2WDVtGmZlWWXBbD?=
 =?us-ascii?Q?yQEyWtmrL+gAPFlWskkAQ5O/JVpcvZaQr6sGwlvgx9eGsVY0wVmBZ+1wjLIZ?=
 =?us-ascii?Q?Hsi58zLwQvBN7GbA6f9iwSUxInWOfsnvlsJjRad8WWwDaHzqfJtsPQaj4iyp?=
 =?us-ascii?Q?5/lUTuSVScZKTQ8JRL/FvdMEhRM5rdYynbuSHtGOapxJRbivZhWTs0/K8OVP?=
 =?us-ascii?Q?MifVrwQlNEXuNVYMC8oCj1nW6Q8NF0jUWxXsjemup8wqNIn+kFRxac/iHCdS?=
 =?us-ascii?Q?4nuiJSG59HreB3/Z9U6/FrkuT+7UaECkSIEBnBHTkeN7FV/ohjmHOn57NsGL?=
 =?us-ascii?Q?ON0Onnhdyxd+RzUNkdcgQ3yl24dj2ZVpqCw6T7EWaM89WzPUI8lPWBbkmeye?=
 =?us-ascii?Q?bXz0Nz/TEVsdTVouaPr42lH8vkbxdxoYoi/aGR3HwpnZB0Hh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c304a092-74dc-4f3b-e75a-08df280c3068
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 02:54:52.6476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDoOK2kDpLv8qlXRuPe7xLrlfndecK6AYQ3ou9T5Mi5bbEek9JXWDxutTQSWnnC5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563
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

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Kevin <Kevin.Wang@amd.com>
Sent: Monday, October 12, 2026 9:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: mark the current DPM clock level active

PMFW can report clocks outside or between advertised DPM levels.

Report a clock below DPM0 as a special active S level.
Mark the nearest level active for a discrete DPM table.
Clamp a clock above the table range to the maximum DPM level.
Keep reporting the actual clock for a fine-grained DPM table.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 35 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 361657c19ea3..8cf616517ddd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1391,11 +1391,12 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context=
 *smu,
                                 uint32_t cur_clk, char *buf, int *offset) =
 {
        uint32_t min_clk, max_clk, level_index, count;
+       uint32_t nearest_level =3D 0, nearest_diff =3D U32_MAX;
        uint32_t freq_values[3];
+       uint32_t clk_diff, level_clk;
        int size, lvl, i;
        bool is_fine_grained;
        bool is_deep_sleep;
-       bool freq_match;

        if (!dpm_table || !buf)
                return -EINVAL;
@@ -1407,23 +1408,41 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context=
 *smu,
        min_clk =3D SMU_DPM_TABLE_MIN(dpm_table);
        max_clk =3D SMU_DPM_TABLE_MAX(dpm_table);

-       /* Deep sleep - current clock < min_clock/2, TBD: cur_clk =3D 0 as =
GFXOFF */
-       is_deep_sleep =3D cur_clk < min_clk / 2;
+       /* A clock below DPM0 is reported as a special deep-sleep level. */
+       is_deep_sleep =3D cur_clk < min_clk;
        if (is_deep_sleep) {
                size +=3D sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk)=
;
                level_index =3D 1;
        }

+       /*
+        * Discrete tables mark the level nearest to the current clock.  Cl=
amp
+        * clocks above the advertised range to the last level.  Fine-grain=
ed
+        * tables keep reporting the actual current clock between min and m=
ax.
+        */
        if (!is_fine_grained || count =3D=3D 1) {
+               if (!is_deep_sleep) {
+                       if (cur_clk >=3D max_clk) {
+                               nearest_level =3D count - 1;
+                       } else {
+                               for (i =3D 0; i < count; i++) {
+                                       level_clk =3D dpm_table->dpm_levels=
[i].value;
+                                       clk_diff =3D cur_clk > level_clk ?
+                                                  cur_clk - level_clk : le=
vel_clk - cur_clk;
+                                       if (clk_diff < nearest_diff) {
+                                               nearest_diff =3D clk_diff;
+                                               nearest_level =3D i;
+                                       }
+                               }
+                       }
+               }
+
                for (i =3D 0; i < count; i++) {
-                       freq_match =3D !is_deep_sleep &&
-                                    smu_cmn_freqs_match(
-                                            cur_clk,
-                                            dpm_table->dpm_levels[i].value=
);
                        size +=3D sysfs_emit_at(buf, size, "%d: %uMhz %s\n"=
,
                                              level_index + i,
                                              dpm_table->dpm_levels[i].valu=
e,
-                                             freq_match ? "*" : "");
+                                             (!is_deep_sleep &&
+                                              i =3D=3D nearest_level) ? "*=
" : "");
                }
        } else {
                count =3D 2;
--
2.55.0

