Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AADC47082
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415A0613E9
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415A0613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059166F49E;
	Thu,  3 Jun 2021 15:12:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834CC6F49D
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR34k2rHR3NVPz++AjkHJv80cVTOjk3ri/72+03ESjKnGAjLC5z99ssz91bYGTV79lzHezo+HDtzQDunJht60l4dIjYep3vyFGwmbwZj2vvqLoFLPqtIm5RBRWie9W1IuOfstdhFQfl4gbtHZIzKyArFlEvTHqwqkZlzKsR43t78UrsY0ECDr3tTGb25u84d85s1jguXH4/zJkWn2SZlnr7F2sD9YyD9qvrJA7pFTUsi/jqXuohBlNcds3nMlicpbpdrf18XJ0FveBHnc67oyp/dZ016RwqYco5Xe5SpIZ5IyxbtsuREGeyN57Q2iEpOdYMHxtVVJBUq0H7Y6ZhkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRblipSZOmaB1aM3074L+S7J5PwR7LP1sF7ASxL2Z8c=;
 b=XZ47EeLOf05fQmL3malN9nCv8C+8LBO+NBrnTz+tdfhmc6mVBMpZm51rOIjj15owUoiAeXFQ7oYGjCNIIew4tFCxVTCIr8PSRXiAgHDME1xeI9kIvuDvB2fhBN+JDfH+wQWEXrG8PEjEfSk753KofnCTnVXvbwaophxva56ubM0aIosQ58cduFQSXnZBcKPjFNOJTDOlpvcYOipcee4LWG1mGeadOmpgVqFvd7yH3doSHMrhcA9dEYP6bEnGj6Gkkai1ZZJlghK7HED38K+DK99OuT8qWlw+n3+btPlqwRgHnQGC6i9XD87G0JLDOpHKeVwTJNBEi0WrVSEA+t/xOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRblipSZOmaB1aM3074L+S7J5PwR7LP1sF7ASxL2Z8c=;
 b=wfM3YYw9k8xyesLb2ad2dSDDmxOMz13nKv17WZ9iYXRSx9uy6pp5oR/fDZweioWi5QA1i6UICmSsiPycG9/WMYzaGD8Y18BWAOcdlN/ItqGPFmd4pNqiHbgAC1TkfOdn1A3JIvjL9+z/mlzgz5vgQQkdzPLTPwS040gN9Zie1kY=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Thu, 3 Jun 2021 15:12:43 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 15:12:42 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Topic: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and
 aldebaran sriov vf
Thread-Index: AQHXWIKmEG+ZmbYjpkC2lA4Z+/AHCqsCZIKQ
Date: Thu, 3 Jun 2021 15:12:42 +0000
Message-ID: <DM6PR12MB55344CFCAD9394BC48B36665F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-4-zhigang.luo@amd.com>
In-Reply-To: <20210603141305.2542-4-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:12:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=537b63f2-7f85-4b82-902d-0032578406c4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ffefe0e-ab31-4634-b5c9-08d926a20917
x-ms-traffictypediagnostic: DM4PR12MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB532597540E9041728D7FA676F43C9@DM4PR12MB5325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wsy8gvMQEqYZegdV1sZmyTesHD6lzYpR5WCiEo+hDeIFAJPSiY9XKl7rb9Pz2xjM0f8tMj3wqYxRddlGveWnFbW730RHyldnNq/vdjw70614oDi1PGetAAfX1TWsa54ZSfTWHmK8kzV3tBVDHZRSaNO8jCEmRKxIhKBvwofQTNdf0CFUmB4EDt9tHYypRqPWTy9XedtKIggqmTxd+6fib4hofM6C+UHEr95MQFfBrmGaK6UhkRl6drjenAYZYa0t+edwZYXgm+yBKb/bdP3ZpZTk0l+uh9L+IbT9xLWpmQVP7b782LtSxb53GciiqG46/KKtupBgZBjREWewQzsWvdiWUOgb/ELaa8NAK2kIgwMkR67jIJ0ZNY237nmhSD7ezSL42qF8xHlGQgQFrTbxK2O9ofGQuSmjotjNKg0XtnNDTCWlNDT+wQOBvQzQmP6Up4GN2MhP2Sbq6jWadla+2L4QXBHIpXxDHowDx436/gBPLak9ItnDK9NiXm6Tk6lVCfJ2o+de3BUz+N+6I7yRnbW2lbN2FfunZ64fI8jNoZcM/ijKP/drKTEWz3SAi5NggLNPeLXH9FM3ciAX8sToLNGUFQF0KyI7Lgr9no029y5H57vs7jz2Kb3DXL2DzG1IYw9zeuyFc5JnTPJCh0f0Ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(376002)(346002)(5660300002)(86362001)(9686003)(7696005)(71200400001)(55016002)(53546011)(38100700002)(52536014)(122000001)(966005)(8676002)(8936002)(478600001)(6506007)(316002)(4326008)(26005)(66476007)(66556008)(64756008)(66446008)(2906002)(76116006)(45080400002)(66946007)(110136005)(83380400001)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cEOAbH9nnFqqxAqD2undfEuV+e629onHNHwdh7SJ/YxbBkjL/g3awxNrD5GK?=
 =?us-ascii?Q?raUG0Q+SgOvOESUQUwNSQpYxHs1hBH5vGQ580qlyZ6rVqbzbypSAS9JWfLpO?=
 =?us-ascii?Q?yVthBZkjfyVx04IueTQzJEj2ZlZEs9XsZyrUx5C8AvqUKjQFzF8TkqkgZ+69?=
 =?us-ascii?Q?0smM882uL7KaLWZrxjXFr72IacPJYsFYQgr9EZV45xL+YDvN3Iq34Zy4021Z?=
 =?us-ascii?Q?htMYmK+GkgZ/N3iincK/1LUAEXuakFQullHTaJDNcGxjb25jRxygVBNVE34x?=
 =?us-ascii?Q?tfzjW6qn5RGAJ/eHNjueA6z3w+rpR1eVTcertJ6LvpSfDcC3ZkdK9QQYIS7h?=
 =?us-ascii?Q?xRhkXT1pSQGW2ZkUF2AHg+vA2gDnThXZCPLxe+4XRnd0vyIo0zOdrWODKHLL?=
 =?us-ascii?Q?xesSjyRb/sPEvgc91w24Ss/ro4/4oNYijCpLpIybGL450B0NKVgpR6Y0AtNB?=
 =?us-ascii?Q?yH8oNGQ9Zh0WdENSMiyWnElW3gBtvPlv4lx85zqLAJu1mBhZ8yct+vFPznpe?=
 =?us-ascii?Q?9+5uOcGRHsUe/d2zMNF36O+xq3vedi0aoZvFt744N2RDVFnYy4OGtsPdwpa/?=
 =?us-ascii?Q?j882Df/1YddZjl2pHGBRu3JsKQarYjTbzqY9sS6v+0hGf/mqsJb45A/fhe8L?=
 =?us-ascii?Q?HWpx6ysBky1/Do8w7SLZK6nAumfASJI/ikz06VwbPRNXhwxM2lL+l/cFWAZ0?=
 =?us-ascii?Q?KWace0yW4gLfcYGdQ7np0RE9K2xwubI8TuYmgq0qXChkAgTLcKWcWNE/A3xh?=
 =?us-ascii?Q?WREq1314JmIh7hCEgSuGQkN/9x1CU0nZcLCPs1WYeMnFO9bEZ2QsGn++S/TL?=
 =?us-ascii?Q?jJVASDlB3h/+PIQZUzcVjbowARV/PvfW71NJSUUzfOTMG2WH6zEbXUQOybLC?=
 =?us-ascii?Q?ou8mA4oMXzWVE9P0U5ORE16ktfH6w0hW0sMi5i8BKwSnI+FyQBgVEhodi4G4?=
 =?us-ascii?Q?YvsduGV/7urWF4xoddZQj22EvPPg7+ZtQ5MiBl5kIgy+7ZmM7xrhmT7CBvE+?=
 =?us-ascii?Q?hAS83p852tduEuAqFnB12IJV6LDApQj70dO8d0uQG80itgxaJ9uOiZDjH+3K?=
 =?us-ascii?Q?Y09L6yKxwkkflOM3AxLwoqEf5twZM/0auoCK4xygGV2PFKxoV67zeZXEW57U?=
 =?us-ascii?Q?vGpIGq1cvlbiefJZ5ohWbNY2vvu8jsVUBVOsqMniAduRizCm3A8DO3Zfrh4E?=
 =?us-ascii?Q?lGAJjVdJKJuDdQkctW8cDyTHe2PKA5lyMc9osr0qMn8h69xSse8wyjyp5/Gu?=
 =?us-ascii?Q?T7zN0wLYMI7SGe53ZqNKf/4dRg3y8o6PWGy0+zRJBMmbYHVBucdlcFXsUO6s?=
 =?us-ascii?Q?+CdxnzyyMH0zb57iBpLYyTcs?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffefe0e-ab31-4634-b5c9-08d926a20917
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:12:42.7079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IowEYrX3Mlu8GwXmhtk2xiKnrlr7y/xL3ECw2vvHSCnHItgMhWT98D8o7RAjV2AIAhDaluFjSW5mDbdJX98a1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

This one  doesn't looks apply to  XGMI TA  only , it's for whole PSP init , can  you double check it ? 


Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add psp microcode init for arcturus and aldebaran sriov vf

need to load xgmi ta for arcturus and aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..6bd7e39c3e75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -170,7 +170,8 @@ static int psp_sw_init(void *handle)
 	struct psp_context *psp = &adev->psp;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if ((adev->asic_type == CHIP_ARCTURUS) ||
+	    (adev->asic_type == CHIP_ALDEBARAN) || (!amdgpu_sriov_vf(adev))) {
 		ret = psp_init_microcode(psp);
 		if (ret) {
 			DRM_ERROR("Failed to load psp firmware!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C7568bce040b840a5a20508d92699c7ee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264190861368%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZL8oC97Rnltg0gbqc8AUqnZS%2BEuUSq8%2FDFngzjjFtbI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
