Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895CEC28B2B
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Aug 2022 16:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 013C610E7E6;
	Fri, 19 Aug 2022 16:35:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA0E10E7E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 16:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a06x8DDJLtKogeYqHV0+79RtDgxsF2gODfAASc8bPQpNAP+WgaHUPx8fNBjApLYx0TTmNQh7/j9vJ6VowRh2lhTlRcoC+sKPcj0w4dZpYURXyOCDxAiRm0gVW3jNciKjQ9gzYMV55R+Fn22uVAar/gf33W2itTeDeNnkvb9uCtLU4SPP822BMveAcRAnlq+8FV59IaDoRYbqP9HPM6aUt19SuFeucdp5RZl+ypAgsC0sSS1WDbvkUcdFldiYfPdqeug5rPXu5B84ysoMpn6LtHtCMBiqtOWcM3FWE7IUwxozqztCSQQUQ17luJXJLmsBatoNGRVLYgQdFTd8SzwoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRhiHKR7PgVXELswqy4RjBGkAiybrsgaNESSxeLo4xg=;
 b=XWAf8boHGWbPhiuFTXtEvAFE6fKVhhMl1qqbSjhYql15OtwjV377EvHd08vsZ18MUu+5khFcucm9tlvhE0sY2A7Ut+VqnLopCRhmXb8GVgJelNKtj1UOBb4JLWri1iUJY8qpQFX+q7l0zkEGOyk1iaZ1+bpNYv0IzuPPo3gFTQpSeiedCRbkpTld6obeIVU11w4eIvTV0dM+hZjC+3kGyg6W1XoUTLcjNtYXxfU7WOpQnwKJ6v35MWEMIdQzlX/erdr9NfgjDfHxWqbiZdpnuZA1lBRQydNkEz4f3gNzqd7v2KDdEUVLOW0TeUngdoT4GWEnctGPqEw2dQwOyFmLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRhiHKR7PgVXELswqy4RjBGkAiybrsgaNESSxeLo4xg=;
 b=DC91XFMiiieIvnOY9YzptE7JBsUtJE1tt/Acplfv3llMl+S7tQzozzyFXMZwalSupk33eHNF4qhsoyd1nwzKfR2ozv6VnpbLYYTMpezrNIbhutbBHT/sY5efKDM8riMmSSYZcbSeBBV0rsCdYj0fVjLkehatIGcgbccMCNdM/+s=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by MW2PR12MB2348.namprd12.prod.outlook.com (2603:10b6:907:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 16:35:24 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::10b1:8de5:fbb:2899%8]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 16:35:24 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Chander, Vignesh" <Vignesh.Chander@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip set_topology_info for VF
Thread-Topic: [PATCH] drm/amdgpu: skip set_topology_info for VF
Thread-Index: AQHYsyk0uWxAuk3Q/0mgkDFCDHcaTK22bNxg
Date: Fri, 19 Aug 2022 16:35:24 +0000
Message-ID: <CH0PR12MB5372484853B50028C2311F76F46C9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220818173810.17368-1-Vignesh.Chander@amd.com>
In-Reply-To: <20220818173810.17368-1-Vignesh.Chander@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bee6e12f-64b7-4685-aecf-bea33ac969d3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-19T16:34:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f54253-497e-4548-ab02-08da8200d129
x-ms-traffictypediagnostic: MW2PR12MB2348:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3D8PDBfpnlBtuQAAg9GUhilcs/SFJEDEOSbKzA/v7P3BGf4kKqN19+BTSEx35jLCEhGCkTqQ0XazH5dYiffTVTBbzatbt5ls5/EPrrUnoWDXPxDHE1naAnOJOYMmrCNiA1nAd4HUCQWr/MJ/6C5j1GfbHCIvhUl6aabu5NQ2hEaDINrM5j7Uq8Ox91sbf0SVQuj7olvxJIKgWYL56xuZbXyzveKJdtpzZ3LmTDWizt93zX2LHMsmDxu4X1wlwmRm426zfA2Imo09eGp78U88QX7KZAyQ6KxYBBlNFcsPbU1COyPfFkYU2GuVE9TRH3Hrnmgh44b4pf3EAI5U1bOcnmicICpG5Kt1cdB6cQQm4beptBr722+gpK+P4oH5us8rAlI+ZtqGpF8kZOqfzd0nGQX9aYMl507E1rApiTe+TDeC/l4irpMhjZI1MQ9ct90nkyUGUg6F3VAJApgIaUvRWvXyfU5d7Q1QRIHZxyVIi8CqfIx25gqNUJ/41XqPTsRoga7CU5MFSTCOF3HAFj7vc+tLXlf0zrIa97NRNPFHESED/EHQ9GRLHpUaR6SUCSjzJuw1tyDRX5Sz7qa2H15eFkr/uKP0JGCO4Vqw/2fxct6JmSwk6HPEAFYYHaUJFXnMSYXLVolqTA6k5WFDcucnCYKzqGNpjbCms3gOxQ6Pv9J7mnPFA4lAc0OdD/DR06UDAwBx9bsetdXKy6g2oZtzbqXsLvq1PMhMZPmVPnsy3Ev30MpkJiKOnt1OpBYfeLuEchc5m1dts3sq1uAS1xShiw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(86362001)(71200400001)(6506007)(9686003)(7696005)(55016003)(26005)(41300700001)(110136005)(186003)(83380400001)(316002)(76116006)(4326008)(53546011)(66946007)(66476007)(52536014)(66556008)(66446008)(33656002)(5660300002)(478600001)(2906002)(64756008)(8676002)(38070700005)(38100700002)(8936002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iRqQpMnQ5Wfj0EfOOmVzqt0JC9s+YCCVaoDZO3/efGxppzJBsPrWF7l56Epx?=
 =?us-ascii?Q?078hsneSkTNuL7GXsmj8oso72AJha5D03vJSFCgbyxvU6gE9LQJ7KpNX3cGC?=
 =?us-ascii?Q?z3Xu/zaDCz4LFuVdjYC3XUTAa6ChUATkrZ2+wcctr1HayZ2a/KAIZbOAXPsV?=
 =?us-ascii?Q?/FXmabrQj+qNuQfjeakDdzQ0z6IttnoBDNj5hRk05Dj/GjWZ2Z9Y1p43xgZo?=
 =?us-ascii?Q?thwTtP8Gvdo0q1n9YjEc/Ef6idCY0FfKKLncimNBV6bw6pbpVvDN2cTNvbkU?=
 =?us-ascii?Q?A/xaesrGpm0yB8PKWg07if/6bgqxCUBslbef8cQ4AidldDfJVxlwUnj4ggnO?=
 =?us-ascii?Q?OuKtXKtVJGcvp4Sn1Pv7PsLM3q3xFhr1ggvByDdt4tha9Aj0tm13EEmfn9yD?=
 =?us-ascii?Q?zaQApPvXhWKcEvvIu6sNHR4NzekUlGPAuHdae7fRKLrJJ2XRdVRY19ZQQof3?=
 =?us-ascii?Q?k6xok5MfO02vyETC5zRNsvCXACVlYxpv+etcNJKz/7ukLhduJ3vQsYNPYLy3?=
 =?us-ascii?Q?nD4Yhr/rKsVoV6bRiEeT8w/Vhwe0k5+6B23Paruz15AA7UWXmzsIndA2EVAH?=
 =?us-ascii?Q?oGCOQoY6Gils2aKLCF1m228q6KKnKvuQJ43ZtpYtoljAuCQW/4Hdm+73GB1O?=
 =?us-ascii?Q?mxHA7iY6iT5aRvnYsNK4WzkBz9Q8XYe8RqLJEAwMW/XkTHSgyqOhJ1nAYaow?=
 =?us-ascii?Q?2kmEwZIEt+uHv2y+SaaUO+c+uT3ojtD7V+j6/JjiXwNQuXZeYLncFBhhBnal?=
 =?us-ascii?Q?jGdyhkxRtC+UDSzIb4DXPKd1W1ZOdhdhJ0OvlcooGHJlAgArDPb0YxHphOaX?=
 =?us-ascii?Q?h2sG9uDza683ZlKYrE4Dk1ja5tJqlsDMgD9EJQ1POX8PqfWe80mKazcg6GJa?=
 =?us-ascii?Q?sCEtoMdNzugS1rnMO2uD/erXl7hOAfnU9Ht0NZ4GbYxJcLcYfN43MoHn89Mq?=
 =?us-ascii?Q?AqkDk2DceMF10ZIQyIR/iHfmvXwdIODz6N7VSKW9pXiKLRVjXDoJPtIxGpue?=
 =?us-ascii?Q?b4GJRaWan76Mc0si6iPcRHvU2rUJ48lfLDSTkEccT8GcIA/NBBd+3xl60gnJ?=
 =?us-ascii?Q?u3VaNKQaYwURwF6+p6EoCjZSpAjM6cS37IHxh827pozmA2JWS3wNeb8XR6kN?=
 =?us-ascii?Q?9ntAsfHYNk6Apo0B/fklgOhbcFc6FW7bdyt9sO0nrlZuCLvcljAQzTNIbJEU?=
 =?us-ascii?Q?OGmdy4vwrZPdY75neYQH2WxXJPXWhW6TIQWje0rLU10hAlOcE86LpJGiPUV6?=
 =?us-ascii?Q?PGoJ2RJfK/fb4xaBtlIiDg5gXdCHn9egjzV4KVhmMEIJ1HDWTxbd5Y/cNcaI?=
 =?us-ascii?Q?xL6drjHL1+o8seyChNqgLa1h7d8hhlnmXOR/voXmvWVpQAGO0x3cPa4zor/q?=
 =?us-ascii?Q?Cq2vfa8iLw+L515hr82B6fokYKb7hQ4MrzidPIn76xgL/bj1znbyxEtLFBEE?=
 =?us-ascii?Q?dAtyh7l9m7/aN09/CqokuByMQmj7d5ajBjN0luCRQSGIlPhFkWXn1pYPLDZE?=
 =?us-ascii?Q?oETATnQIO1Uc2kMiJUx47N7YMWlJTDzMqkLAGErPOB/sQw/aqGW5mhEcDoCy?=
 =?us-ascii?Q?QiRobdhpYJsaeXXWRgg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f54253-497e-4548-ab02-08da8200d129
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 16:35:24.6813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+l3T+0WgEAjHr3bG+z/b55vG6I5ieW0ifiKPudMlRHNy6SiY9DXB/Gso/6ToUp7zCLHbt1Lrm04AQxwteVSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2348
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
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks good to me .
Reviewed-By : shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: Chander, Vignesh <Vignesh.Chander@amd.com>
Sent: Thursday, August 18, 2022 1:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com=
>; Chander, Vignesh <Vignesh.Chander@amd.com>
Subject: [PATCH] drm/amdgpu: skip set_topology_info for VF

Skip set_topology_info as xgmi TA will now block it and host needs to progr=
am it.

Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 1b108d03e785..1a2b4c4b745c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -504,6 +504,9 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info=
 *hive, struct amdgpu_dev  {
        int ret;

+       if (amdgpu_sriov_vf(adev))
+               return 0;
+
        /* Each psp need to set the latest topology */
        ret =3D psp_xgmi_set_topology_info(&adev->psp,
                                         atomic_read(&hive->number_devices)=
,
--
2.25.1

