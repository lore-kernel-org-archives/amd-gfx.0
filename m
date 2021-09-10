Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BD7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 05:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6AA6113E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 05:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD6AA6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD286E961;
	Fri, 10 Sep 2021 05:29:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB806E961
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 05:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry/R/QzxkdU02TFfLRSfr2igx17PSZP4/3XkUeh0xgazJXINfQGL4cKbKEo8x+yIS6VojJTUi4bTkFnjLWBqSgvhKPrSminmX/p4RHItqChITp1UO/nePegokVnl1JKKo45B/+66mxuk1DmAtswSeovEI8n0Tb3jx/OoM8Mj6tQCyVy+VlMyjZjbXUE6nO3JY65SYrxzklAfyH5UnNB+tWVYgrEjD2lKb0los+4PMl7IkWGR+NDPN0se0zhG7br2kdpQIfGx2eGVOQwH9JwM5rhOUR61LeuewjpUM9DQgZr2n3TcOoxBUXjdVXnt8FWPk7dQy5N0o0N614AjqEZgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=TVCYjTag6s3S5Y/D4L4EIYFZbpKkSft1KXRVUgDQoXM=;
 b=RY1/GGRwZ5b6iPmqi6yAdzATbVRTeqinnr8Q5pzdnmbQkSOob5+u1RcWApYdVq9qnZWptWFh3G6JbdRQDjYd2Ewe3vftBX4jyJ9Zp6yZTq716SXzmFL2+ySZxd0kLilfLanXKkrqknd3QQYDyYb3WvS/sRYst+OcCYCA4haKLU1TrKEyrla81tZHIoKg9Bz0o6+lIo91oAySz7v76O2bzZwnTERZ63ZCYFK08ROjJQ11Zx+sBQ9OGtUzuMQcH3SoX75k/bcUECfVp6VYPHpPStR8YRTg2TD5OiTslyY66k5mHLXiYgzQz2+lUvfBhiu8qmBrx+SrbW0nK8nJMaJxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVCYjTag6s3S5Y/D4L4EIYFZbpKkSft1KXRVUgDQoXM=;
 b=vNZ4ZBfuWhwoG0vFxDQO0eBUDxGjhO8YEpofNRsuCRcq0b3Qj97mHCXn6bPFeFTihjfwZlDOXmpEWmD71lMhUvaxmHUpXNdUl3ubVF5WaRpyvsf4+NiJPsr/ssGJmxZtpYs4kmnkuKCRbCpQHb4xkKnb5QUI7EWUdEWT+m14BOM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB1257.namprd12.prod.outlook.com (2603:10b6:3:74::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Fri, 10 Sep 2021 05:29:03 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::54e5:e9f1:8883:e8a9%3]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 05:29:02 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix runpm hang when amdgpu loaded prior to
 sound driver
Thread-Topic: [PATCH] drm/amd/pm: fix runpm hang when amdgpu loaded prior to
 sound driver
Thread-Index: AQHXpfKGi9drP+7yiES0710ZoBe+V6ucu+cQ
Date: Fri, 10 Sep 2021 05:29:02 +0000
Message-ID: <DM5PR12MB2469922B1DF22F8DC30E8892F1D69@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210910031758.724964-1-evan.quan@amd.com>
In-Reply-To: <20210910031758.724964-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-09-10T05:28:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e3907a24-b4fb-4c5c-9138-680a8a93cb4f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f647eba-bbcc-401a-3946-08d9741be677
x-ms-traffictypediagnostic: DM5PR12MB1257:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB12573F8925319D79CCDA0BD7F1D69@DM5PR12MB1257.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIhiuTxThurh7CifVXHvmS+Rjs6rraOo3BtO2s9FN5HzIMyAHsme4RHI0fpolfN8shs70ybN9soikmEiFEmPpswrRTHZkdUcrYe4m3JhRUuntaMJRq4FinY3pXiH9iNfddC6W+B4cWEOLoY8TCMf8n70qkwohVUkowEah1MHvP8HeaHAOoTrhUP28jDvIq1/W3aU/L8Xd8TnBPBx/gyD4PafRy7DdkAY+4hKT2SD50xWf/rBxNtzbiJ9MId1QIvx7RpskR25nvuYHSice63Tk4AJgZZHzd6j7WRd2weaIljpPDYyf77WnoEthJMr9LtKT+blM4EVYCgfAZQiYR2uHVDq88f3P4ydHKXh97U9guz8bAslWFrS4JlSSowKeSlpXIGNQnpw47ct7+/Lvs/id4sEN1/KxulKAx/ejqgGcf/68UpQufpM2O/QOkrgu1NrLpTLVeH3OBbz9onTefFBjbAlvbMZzIwEtw4PqEtEsaxlHOzoR3MgNPpXGI6Jdy9ROVEFI0VrKw9cyYxKyVFujQAWVDHQq2nJZFRAPeq/QafWvlwv+6UJ3pr+Xn99t0eYIW15gJ5NohWcns0T5thnYltOIu6A8KJILIfD1BYoHgnWfGEgMpqdELYGVrDMxv60zL0y+gh+Hwsa+vI2rdkdd4uZSiHCwWTZhFF2mGX6zWmzUAVKVRcwSt7ODSsQN+XUkZfRMH1CK8IOlhHSF+UQHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(76116006)(316002)(8936002)(4326008)(6506007)(53546011)(66476007)(478600001)(2906002)(5660300002)(38100700002)(86362001)(38070700005)(52536014)(66946007)(66556008)(33656002)(9686003)(26005)(55016002)(64756008)(66446008)(110136005)(186003)(122000001)(8676002)(83380400001)(54906003)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wj5i6iofUEfxfKz4SzqSlDAnrL2KCTw1YOyNLQQ7te/d83WiHxFtmjvQpqJq?=
 =?us-ascii?Q?B+nsOe2r9L4GG+VAIIHVIPGevCfqF3qktPYtThGj3sk8dElv/xNRtTBCQqd1?=
 =?us-ascii?Q?OOAp7E8Cxh61PykdDzkDocmV0thFMgQwBOkB6U9/Sw9iBe1wVVgJkf9FYJwo?=
 =?us-ascii?Q?s9YrpK8qCeQ0fytkxY1dvk45yl3LACCtWE2qlPoAiu623uhErJyN5NY/pKbx?=
 =?us-ascii?Q?FAxYfD5yxV9S2AaTtIvTinK14sHrlwWbV6aw6LwLEIqqNDG3ynTNyDTUny3u?=
 =?us-ascii?Q?Im7jW+rb20PObZLPt1qu3TG3RVZMgMixNA2Xwv4SEqICuRxaTQYgOHVTIi/V?=
 =?us-ascii?Q?ACwXWrB/k47QxCI6YZIEtqBWqSOwdf+Xr1PXUPc5Wo5YrpB8+5OIqUb3aWTD?=
 =?us-ascii?Q?njOkbuGUJQK0HbjYLqpXqlVT8NucBhOiiv0BOsYZBinvLbs94WL71weAHRll?=
 =?us-ascii?Q?ujuEHqQq0xfVdPfoK442ZOmc9xYaGtDVVckKBDVpAr60zvaIo24lHtoz1uoB?=
 =?us-ascii?Q?sADhghgD44qZjIwKxtnL5os8mahc3gk+mIBLAaRAPjpM6g3ufoBppp7Pmemy?=
 =?us-ascii?Q?eS5/YVxD5zXY6aMmznpWBAfWsJ0jwxJnWxwYnZo0/AgUCRXZkUE6gz4LTxj7?=
 =?us-ascii?Q?PKOq5bgEXq4aEoovAsZ4jRLAjKdqcH6d8Ud6cl3WEjqkDzxifMAhx2gNF38T?=
 =?us-ascii?Q?V3aZbEvUGrXr318rTmbSUUlnEMicBAJX33RZDuTlSmb+3eGVF+m4X+GClVFf?=
 =?us-ascii?Q?3FBLyRsYFX8nnttDAD7/U+vUUVeNZp68vaWpfc/vEcJTBIJe3nJVq0wHKvnZ?=
 =?us-ascii?Q?bvrrIDpK+l4k0dQarFxkdMuHQNMZ9LFQZV/YM+tlt7adcRnNouHx2tvyxqVO?=
 =?us-ascii?Q?aO7d5bilSaJUEiSrRZVccBLLvFzTC4knKF1UsqTKYJSBtlWVBSjBAnnCzOFC?=
 =?us-ascii?Q?4Cef5nGXeI7fQKI/RiOACRAie/bFouuuL9bnsAD87O11smNjmhtX/mCKlIp9?=
 =?us-ascii?Q?Ao9SQBkE7U7W87RUsX4IawoejoT2zi1/VM6Lk0Kf1pkCM+AyfEB+Ry1DC6XM?=
 =?us-ascii?Q?PfcfJFjzzlavHVtve+g9b/gE5LJS+/KpAd7DDoqHCY9liSvkLnaXsGxfaGOs?=
 =?us-ascii?Q?5pT8LH657m4UQL68blOkLyDyUCrQkzlN4DOjqzJEchSAk0r25DAMA0/zB6xv?=
 =?us-ascii?Q?hAayw8VfujhIpu7KpMMmpRmp3erYpm3vQlkfOQMHa4H4PQWjQlJx13BEJC06?=
 =?us-ascii?Q?NWnGvHye9ssOHqO2CbHJf1AJuckkSmUCF09l6hGj0SqBm83bH+WC4OWSULk2?=
 =?us-ascii?Q?V1iR80aZ7S58mTUev0wUH8Pn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f647eba-bbcc-401a-3946-08d9741be677
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 05:29:02.7019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlg7GoTjVkRWhrCnyK7F5b72WtFjrEPO0oqghchOGfXZAFergJyGTx0PkvvZk8LV+VUnktyIm8BoicR0XYeB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1257
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Friday, September 10, 2021 11:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Pelloux-prayer, Pierre-eric <Pie=
rre-eric.Pelloux-prayer@amd.com>
Subject: [PATCH] drm/amd/pm: fix runpm hang when amdgpu loaded prior to sou=
nd driver

Current RUNPM mechanism relies on PMFW to master the timing for BACO in/exi=
t. And that needs cooperation from sound driver for dstate change notificat=
ion for function 1(audio). Otherwise(on sound driver missing), BACO cannot =
be kicked in correctly and hang will be observed on RUNPM exit.

By switching back to legacy message way on sound driver missing, we are abl=
e to fix the runpm hang observed for the scenario below:
amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded

Change-Id: I0e44fef11349b5e45e6102913eb46c8c7d279c65
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com=
>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 +++++++++++++++++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++--
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 21 ++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7bc90f841a11..bcafccf7f07a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2272,7 +2272,27 @@ static int navi10_baco_enter(struct smu_context *smu=
)  {
 	struct amdgpu_device *adev =3D smu->adev;
=20
-	if (adev->in_runpm)
+	/*
+	 * This aims the case below:
+	 *   amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded
+	 *
+	 * For NAVI10 and later ASICs, we rely on PMFW to handle the runpm. To
+	 * make that possible, PMFW needs to acknowledge the dstate transition
+	 * process for both gfx(function 0) and audio(function 1) function of
+	 * the ASIC.
+	 *
+	 * The PCI device's initial runpm status is RUNPM_SUSPENDED. So as the
+	 * device representing the audio function of the ASIC. And that means
+	 * even if the sound driver(snd_hda_intel) was not loaded yet, it's still
+	 * possible runpm suspend kicked on the ASIC. However without the dstate
+	 * transition notification from audio function, pmfw cannot handle the
+	 * BACO in/exit correctly. And that will cause driver hang on runpm
+	 * resuming.
+	 *
+	 * To address this, we revert to legacy message way(driver masters the
+	 * timing for BACO in/exit) on sound driver missing.
+	 */
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
 	else
 		return smu_v11_0_baco_enter(smu);
@@ -2282,7 +2302,7 @@ static int navi10_baco_exit(struct smu_context *smu) =
 {
 	struct amdgpu_device *adev =3D smu->adev;
=20
-	if (adev->in_runpm) {
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		msleep(10);
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS); diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/dr=
m/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 43c7580a4ea6..f9b730c5ba9e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2361,7 +2361,7 @@ static int sienna_cichlid_baco_enter(struct smu_conte=
xt *smu)  {
 	struct amdgpu_device *adev =3D smu->adev;
=20
-	if (adev->in_runpm)
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
 	else
 		return smu_v11_0_baco_enter(smu);
@@ -2371,7 +2371,7 @@ static int sienna_cichlid_baco_exit(struct smu_contex=
t *smu)  {
 	struct amdgpu_device *adev =3D smu->adev;
=20
-	if (adev->in_runpm) {
+	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		/* Wait for PMFW handling for the Dstate change */
 		msleep(10);
 		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS); diff --git=
 a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/sm=
u_cmn.c
index 69da9a7b665f..d61403e917df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1055,3 +1055,24 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
=20
 	return ret;
 }
+
+bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev) {
+	struct pci_dev *p =3D NULL;
+	bool snd_driver_loaded;
+
+	/*
+	 * If the ASIC comes with no audio function, we always assume
+	 * it is "enabled".
+	 */
+	p =3D pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (!p)
+		return true;
+
+	snd_driver_loaded =3D pci_is_enabled(p) ? true : false;
+
+	pci_dev_put(p);
+
+	return snd_driver_loaded;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.h
index 16993daa2ae0..b1d41360a389 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -110,5 +110,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t=
 frev, uint8_t crev);  int smu_cmn_set_mp1_state(struct smu_context *smu,
 			  enum pp_mp1_state mp1_state);
=20
+bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
+
 #endif
 #endif
--
2.29.0
