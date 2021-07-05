Return-Path: <SRS0=ZRVW=L5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ABBC07E99
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 11:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0F96135A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jul 2021 11:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0F96135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C20C89AB6;
	Mon,  5 Jul 2021 11:08:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD6D89AB6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jul 2021 11:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLzPTOy6NuMErSGoQ6wX9Cy/DdL8F/EVdZrlRbaVEddponV4KGxtEEanxg3pl1Agp5ozIKpEbr81qj03SPWX6/pdYFmhbh+j4dsrCqcBQSFTUhg/A5wBG8F8JsfrRQuYe3w24PiNa+COhiiSwWBGEI486Vchj8JrgYVt7D9AC2MHTqUe+/wpg4fNlD89L61877Vwxqnlv18ZJEJYWQ83aUXyCLJAW8bNiOYWTUu/E2y6vax62yNtvg4QuLDq/YYQk/3ObyR43yEFhiGQE2z2L2px5BI3dg6MQKi4y6BI66hJyM+N6d84N2NoZLVxGwuA9qTREAMou9/97B0fwTQRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgWVB64CzkpmlR5j8SMoO8KRxbckISV9IsVGEwvrNfs=;
 b=CY0PxJRVsn0rcgfWnc+Skgik0sjuZ2IV2yMiDvABy/XEak4jeU+CvVcgNCXD2j8otcc2x6WwtDBwH/SwPkjlupXBhdfWp+v2O4eIYLgmG0711ikSe/C9b8T6CeUE+ocE1Mr7EHo+OtoCHhhfjgQgxofizxzf19k2CbHgnR+KdhTyDUGmuguBbBaqqpa7+dJbtlw77DcHzwMjYtvaRtlK82tPTY9EqeeTAUUSywFZwHSrYZj6MLWlp12ijSB4V2Zlu++JpE1iu6TXfVW9wol2CGyLp8IzIWQfmdmP+3EgQ2KmGbKy4a2Fn9nyThHbvy2CujlFwaJLKJTdnhLPrFjTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgWVB64CzkpmlR5j8SMoO8KRxbckISV9IsVGEwvrNfs=;
 b=MNa0OwBgF3Uv3THYjXMPJAmimv3M1D5u6lojwjiyLrWnNGaXJv1IC0j7J0VwdBwFsqU45bqaWoV0gWRhNavxPpeibCy20mOHn/U2ibDs4fluzAdtnS6oxJklqcCi2N4XWZiQQ1oB/F2pMmWpiK8VleDWzHyq/p6Ifk05Jm1mSdc=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 11:08:09 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 11:08:09 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/pm: Add I2C quirk table to Aldebaran
Thread-Topic: [PATCH 1/2] drm/amd/pm: Add I2C quirk table to Aldebaran
Thread-Index: AQHXb6HrQbiTrcnVDUOlhTuHVkMZtqs0PKvw
Date: Mon, 5 Jul 2021 11:08:09 +0000
Message-ID: <CH0PR12MB5348F4572BA260D699115F56971C9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210703002509.59476-1-luben.tuikov@amd.com>
In-Reply-To: <20210703002509.59476-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-05T11:08:05Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e543ea75-4c67-4a17-9e6a-59979cdaaeed;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.158.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb05cda8-e84f-4229-6035-08d93fa52c71
x-ms-traffictypediagnostic: CH0PR12MB5188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB518894789685907C9C038E75971C9@CH0PR12MB5188.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:46;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUea0vy5LzUsKFvWjUjYWxW/X3EPnw8LKGn9DhxrdqGLpcZqaLqgLxgyjd0w56enE10Wv1L62Xh/MHntm6kMl55wDPsVc3qCcR2IvRAf9dCibKZg/doCOv9t5ZyZQZJDPlyWH34FAdPbPaDjOVCUMdU8hV6atEJrGP/DF/8ob+B18tQ9S85hkekvBdmf9E3WDuJl2w/qmhCvY/2JW3WasQu90uce70rfQoF++8gJf+LA7B/LT5cBaSTL91alQqAxwFMQbmn73glsv4H/fgrCLfWWG9RWt660Fs/ZHH+P5aZOJuMYlJ46mZGtu2wmJffThnw9xNOjf3axc8rvclZxDh+NuKXFHaVJsjuB+o1oI3Sf48Vv0eMscB5n4/bH1etl/PrwJSL4Ka0yMyEdSJU+h5dJis936lUeTHFa2VKUvse0dN92tPjeNMOyeWggLLIC3m5PklZieeBiq1IJY7xNkZJaH57H3rZhgXK3O7yPbW9JAt46cEu07is1HFoKawDGET2gHV3V38XhiPaHSsoBf7bkPD0UTiFClnMC1NFAhDsLX4qjQ/UMct893z+yZEJ9MJaAfwJWDVignN7BpyCiYTyvrDNzUtU4K8UojmgP3ZTlqUMzIzauxilvjE+D0CDRRD3sR4Pgc5i7euYwvDVc+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(52536014)(66446008)(2906002)(66946007)(71200400001)(66476007)(38100700002)(186003)(66556008)(122000001)(64756008)(76116006)(86362001)(5660300002)(8676002)(8936002)(33656002)(53546011)(55016002)(54906003)(6506007)(9686003)(110136005)(83380400001)(316002)(7696005)(4326008)(26005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3E9IMEWf6a5gPhaziKs26qjE0a16GUig/yLQeIKisSeIdDOc4W72v9Y8O3UX?=
 =?us-ascii?Q?LEwcQYY3Uuzi1YWSnjlty4TWugKlU3cCW1gQJcF3VMgmpS6+vDyxvCSjcTRd?=
 =?us-ascii?Q?0WIgabePxn3TainUdwe6gwtHFeXOKjNigRr/84kaAfycVg5EF9cRYShtNtJB?=
 =?us-ascii?Q?MQK9z4VvNPArOOjpmtQ2V+qJwBjFlKJlKONitgIXX16eCTXTpkOZ+WxKOsC+?=
 =?us-ascii?Q?yWtp0MCKqZmTh3Fnv/xprwOEG6WYwQoU2Qa42a2XHaiXpHOa/90WQ1wNB2th?=
 =?us-ascii?Q?jWN+M/jmbgFec6YeC5NUcpmOqHOYkvjPDdz0DTBVtH01suT5u7/LW7J5033a?=
 =?us-ascii?Q?sIT8RB83dBXQqrdxCAsr9s7NYYgW3Thba6288Jj/5ZU9cDw9Bvr7DuNV5jfv?=
 =?us-ascii?Q?i/vhc0J0ZxKdf9V5hs89TASIIX2Zsb0rE0anZI0W2D2m6skn4CKfFOExP+Vd?=
 =?us-ascii?Q?I8yVzqmyR4n9S7hoF8t23UkG5kQFQ6ntuPkH6srb9vnfDdU0wXztrzM3qYrm?=
 =?us-ascii?Q?9LaawfZS4sziioW6WzQRVPjDPLMmocxktR0+/um2JvYCA7PmOdt7Yi26cIoa?=
 =?us-ascii?Q?QNFHjzJZHI/TLP91JVSgIXA+McDDoMuK/wNxAVD4lRpX/f+euVzfcD9ZZtaO?=
 =?us-ascii?Q?z2nKQBJjiYcNa6XiqfE99yhFgBt92mk7ILdX7LvcG89ikk1LvGdpzz8f/mk1?=
 =?us-ascii?Q?kZpNX8oAu16IaWnfb+SXWoKm8FaDFJSQLtqSpz8kqLW6BY6/JunQpOscQsvh?=
 =?us-ascii?Q?6dJ9nP73vDNjL2ID0oAkUPwV8Bk3BlwsLrZsHdrCecKepB+MXLLAvIhHkvew?=
 =?us-ascii?Q?tjL1MfPYZH+RqMTXetQtcoorUuY0cTw5feiXNXEGMdL7ffpI7sewpXlZp8Ep?=
 =?us-ascii?Q?xQU4BvyFN+/hAHaHcKrTpykRJ5SjEBsxHL8LZgHCMONzSoYQ9u9/9BuX5EyL?=
 =?us-ascii?Q?1tEhJU5O9jj/KgT9nOmyhiuJpMcfQK0nBTWsagDJf5n6ZsexpZQ57ZiRaS3D?=
 =?us-ascii?Q?Y1g4rPr+L+T59/KsfFmUuOO70+qqU3P/q7c1kXVSqGCIJ5gUr5lOQ0mpeXQt?=
 =?us-ascii?Q?PWvH5ajyd2zVpA0UwPFVR9fb7hl0dxGsBeZGaDh+PqABAYX6M6b0EbOMdoUa?=
 =?us-ascii?Q?BpQvRaNGUNcI52MwCynjrQsR7LGyCj6qe08ehbKN2h3nfSscvzuLRl264ZFS?=
 =?us-ascii?Q?p03IV1SG30chCs/PjVfe7a+ZQ0gKR19lBavsoSNOX9xG8qVnOwMq9ZXGs4lh?=
 =?us-ascii?Q?P0zQFzWRkirmYX2VZXl4ckwMQ1mVZu0ltApWQgZ0Z2qqfuLgb19j+D2SuLNm?=
 =?us-ascii?Q?bcyTXBR0+E1SccWWm0y0uu4T?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05cda8-e84f-4229-6035-08d93fa52c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 11:08:09.5625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XdGw557e4YomnBmQn263cLBCgzIVbyVfI8QM5nus3wd5NTSDtHeEs31AVkgaKoh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Clements, John" <John.Clements@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Series is 
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: Saturday, July 3, 2021 5:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add I2C quirk table to Aldebaran

Add I2C quirk table to Aldebaran.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f30edf862b86d1..c1c7aefa9d8fdc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1509,6 +1509,14 @@ static const struct i2c_algorithm aldebaran_i2c_algo = {
 	.functionality = aldebaran_i2c_func,
 };
 
+static const struct i2c_adapter_quirks aldebaran_i2c_control_quirks = {
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2, };
+
 static int aldebaran_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)  {
 	struct amdgpu_device *adev = to_amdgpu_device(control); @@ -1519,6 +1527,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu, struct i2c_adapte
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &aldebaran_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	control->quirks = &aldebaran_i2c_control_quirks;
 
 	res = i2c_add_adapter(control);
 	if (res)

base-commit: 81dfdb3e6a907ced8f915da3c65632f7a1616985
--
2.32.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
