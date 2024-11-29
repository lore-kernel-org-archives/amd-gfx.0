Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25DDD70E0B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 03:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3F610E299;
	Fri, 29 Nov 2024 03:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x5sNhdaL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BABB010E299
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 03:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsjRluWdTypPsnklL/F0FSxzqn6CvQa7VZhb40BtBGkwWgBSN8xQ1hCdQSSsQPHCUYm72L1gWrf9W5tB0iH52LdYG4Oa/Yo7royVrWD0Y0V5e4/qTvYN5yUyX1A0wua4D4ko65PFTqYeN5qsrdZ7cxg2DcoZRq2KmM61s3d+OYmJPWFzoGcJ9rUKJKL/h3xrHUWAkopmmP1TSVEd/TShgGETxDGn4qh3eXeB2bzYTrE6C2Eylpf/7jCzkzP3BexoqUO/flv8k23gCFO4f+ZNHkE8WcVMhI0l6kvBTklXGPPy9qwBRj2yDtZrkqulfcL+GszMLbgYWLmv70Cm1Taoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vWeXEiwivPyqVylGspyDOkQqb04+Di3YAC38rOEUaQ=;
 b=AM8obmBUcX2PC5p33aACAPYgG4p6kTxYDchgf20hP2HxcehKAn+1YQs6gpBf0adu0x0dKN7Xxt1s03eWLBLs/5icNz8nzmhBErowk5iz3V/n0ldBCZLuTowSbot94OJV6JPjsLZs1CXDTZwoNCZVxlMJ2bRgT8HElxdpaodw5siza9rbQ7kJEfBJ36pLLz0cyfYbakUUyvwOg+nCE95Z7cSmjD2MtAv2SBdStAQXj0qVtXgfrpVHZwzCWjGqpHpl43OdQmDj01PLPHGgQdk+1bWtnwsO9wGyY1n5BhFgF7iSAzeF/ngaPlgctvHKkD+DR3xeBLcPfHhI3rWtoR8HmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vWeXEiwivPyqVylGspyDOkQqb04+Di3YAC38rOEUaQ=;
 b=x5sNhdaLFGf2tBzVXZgQVuC+QPBw6SmaHrD7hcMSeO4QE9tk4OvaDxtZ0QanV8zT3c3TCCIlv91TvciiDVTUCMjrELrRJOLZzP6P9F/Yb8a+PqofFyiU4KJZciajyPaHloNZUGZDIQNhHz11fEVHaz4bc02v+1JLkc1RbnyY5Cs=
Received: from MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 03:28:24 +0000
Received: from MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa]) by MW6PR12MB8898.namprd12.prod.outlook.com
 ([fe80::1726:1a0e:3e0e:5afa%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 03:28:24 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Su, Joe" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Strauss, Andrew" <Andrew.Strauss@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add secure display v2 command
Thread-Topic: [PATCH] drm/amdgpu: Add secure display v2 command
Thread-Index: AQHbQgbly+Tuep+0hEeqCi3ie6stQ7LNkn7g
Date: Fri, 29 Nov 2024 03:28:23 +0000
Message-ID: <MW6PR12MB88980C5096005A206740C84FFB2A2@MW6PR12MB8898.namprd12.prod.outlook.com>
References: <20241129023010.9624-1-jinzhou.su@amd.com>
In-Reply-To: <20241129023010.9624-1-jinzhou.su@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=56905c2f-6bfe-4186-b0b1-48a3f0669f17;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-29T03:03:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8898:EE_|IA1PR12MB9499:EE_
x-ms-office365-filtering-correlation-id: 5d768a55-a864-4e66-27ab-08dd1025e181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1pvXuiCV9ZQq9ih8J4yCr5lSGFiUQo8seuD9Pn955XTL93kJSrUgMhHQbmPP?=
 =?us-ascii?Q?O/513f/W1XZVRV/sqvZH6U2PD5/OnL3/lXYuaSX6I94ktlixwqILh/bgnWIc?=
 =?us-ascii?Q?0VJyZ9HWmHBlxsRehAobRoxbn2aUFJvDfesIBUaD5KA9gRFxme8UOpmbKlmU?=
 =?us-ascii?Q?nEUcoH4Vy9o+RaP0QRQq9+4IRtYXTrJ76LQCcHVz7W+f1I14CCI03nN1LQ9g?=
 =?us-ascii?Q?GKaBKX8rXg6ggTAk8xlOC3cRulCuRmQbp6Tb61tmQvNFGzWyJQnrKJ3IYi4N?=
 =?us-ascii?Q?uT93HYPj/u2jKxgWjBmc4x2VKrGySBRAsDxOjBYsc50BKbyi8jUTeIv5/79C?=
 =?us-ascii?Q?tUmNBVPQufUUEIrV9koL5KaljSXbu/02CdXj3a2h9lpQckmPoLhkYRuUMefS?=
 =?us-ascii?Q?vfl3WNI9ZM+0qrCShBpi/qkJdYElFXoIQ8KKtd8mHk/oL8h6TCfPeAbEu9jL?=
 =?us-ascii?Q?BsiuACnhBXSRIPO4p/2RCg+SilZ3rgMrZ15f0k8vDrDWlKtPnWF4oPGkx5z9?=
 =?us-ascii?Q?+PvMN+i7EN2g8sx/2LoOi3lnlKfph7fitcclCxGCcYzN3NGmqjQ6Q8vugM8v?=
 =?us-ascii?Q?uFU392oU1qCBN602pomrw+N2FCrobhD6Sg+4vlqo9mYgKFo0H+UXruUMhdlx?=
 =?us-ascii?Q?kooI0pzcg/C/euSjXq6+7N3XVpi43vJBNs3iK5j+ay5FJbIUb4ULUwskquoK?=
 =?us-ascii?Q?yVublZRa8Fe1ITFIvOSi9QckwLYY6WhkK+Mh3sGii6YuSvfDZt/I/kixMibQ?=
 =?us-ascii?Q?Bp77YFjSuehuVyBLDHWHQeSVwVTnyVzQMw5BJ99+cwtOv+TFXiB6sb/tcS8o?=
 =?us-ascii?Q?H/gekgxd9UdIC/iygsRSFRv+fQxGUlcIY97mmnoKpz3BFmzNTVci7USMjBmZ?=
 =?us-ascii?Q?HRQq8YY3HLOMoOfARJqEOtrAS00uMfpe+IMTqWKbOD+NTBL8s00I+ayardqz?=
 =?us-ascii?Q?onqNEtbtW0qxOyyzd7ZdsxeL/fCqlsGjFXsvLnX7YbR1jKLjYoIMRy0oiKki?=
 =?us-ascii?Q?u3eafdT05c5e7zSA/5Ytny1Fe2TRG5BAM8pb4wDLREii5bri7NY+rsRPelEe?=
 =?us-ascii?Q?VaMnHOo6WWXMYVz+7u7L9H2by/wrLI06VdgPtIIUU0/p+kxekP6xKm3X/fjc?=
 =?us-ascii?Q?aJjn1p2HdjGNsFqsSU7sIPFurNqlNyK2IWJ0ZzB/PbzQJe78t3/BpBX6pjlO?=
 =?us-ascii?Q?UIQPRQs6ngtGR//2ZFBjCD4Eyjjk6tgGYTjMx11/QBex6xjyvvdEQYGEZS+n?=
 =?us-ascii?Q?dNRI2z9Wh++D+WicYAjAIhdFV9dODMcau1Vfxf+ecBK+J4G1ns24/NkzAtGQ?=
 =?us-ascii?Q?blS3L25UzEZ2WpIUj6Ox7t8g98el/bLJEwrKD4XgRRqx/Ldbx9uRHTtNiBbY?=
 =?us-ascii?Q?9raKyEHlb6upqzNBjPS0/hYuWNyDKl+I4Jv9tFkDU7oMibFkXQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZoJCtFs8+zxxUK0pRLmivaVm8uBUFCuJAjWMHUGCW/FyIagg1Jb7ZpAHYo8E?=
 =?us-ascii?Q?8PFhOj1Kzy2X4p0cw8uQTXdetJuDgmRdNrlIi/3r5VtaKObplG/qWSHQwIq9?=
 =?us-ascii?Q?pQ9m8yeD9Tdc/OGbjyir3SmJzUpyu2N7fZv4mcGBDIMwBKRndsZxAxvwSXzt?=
 =?us-ascii?Q?W0WvAL5b5f4/Xo7gmzVBZ7bezYqEUAx/HEviOnpe0U7H1uaYbLA8w0GwsgbS?=
 =?us-ascii?Q?PdEVEgCLvyw4YyERSbG2Qfd1He+3LaMnP2RivTnAnmt+j0UkX73POqdGzu3O?=
 =?us-ascii?Q?s3I1ry0sZNsjeLXVLNORPgXI7+KciIwX3SElAVVOoV+1dCB52UzYD83ezYVI?=
 =?us-ascii?Q?MAZo9r2h/VaU6jhwE+lLT5b0fwSfK8KvglslRnYphKtXXSEVnTljlRnZhb9M?=
 =?us-ascii?Q?22h/89N0uOfi7FDI1gY6I1uSdvgvPczyGZc4a3DdrlKYAu2ZDjDeKXR+Rlnu?=
 =?us-ascii?Q?6oN2J7MJPZaEDhNADcSnFXp/Kf4aK966xd0qO1xUg7aUcvfyCODwTqitUcxQ?=
 =?us-ascii?Q?Grqzte5I8Y+lrs11ZdDsir0EaZpXvwDgFBm7tXFjZMTVu185Yap/uiEWJsAs?=
 =?us-ascii?Q?rtCiNTG5aBOusPKjgvESDiZXtuBDT+F0znY/6v2Zx+vwrGGeytqiJF8x4c9v?=
 =?us-ascii?Q?+9ddbj78KBLNezBvbOaNQ1/Kc6WmCfrNsRuoQutBjoNZLyIxpIOBLm5nkhxi?=
 =?us-ascii?Q?0zian1pPOsf77maMkECcTeGR0HPFfXIiTZrbi10RtaqtXgwWvMt+/ohr+8Sc?=
 =?us-ascii?Q?4NVM3jA3qbsPh/lvRC8FdyyBwdZXAjV9pguZmktDpMuyMg720G43A6N/2jTj?=
 =?us-ascii?Q?4+XCJ42u7BY84IR14K8+8wzS8C52AlRko4QGqGUdjIA9PX73dlY8Ihb8rGFs?=
 =?us-ascii?Q?rI9KuB7m7Z6CNO6IDhftlts11A21Ka8x2Zx3XNrDpMjrjz2F7CB+szRovLMy?=
 =?us-ascii?Q?wr/mAnIPBIRjrjJFDUfFUM+7KH6WjFP77q573duTPOXVUj9y0jMIBDgHXmsW?=
 =?us-ascii?Q?6mIq3jb2soo0pWmKLi9qrRlD/NuBVyLhOqOsO4p+xXWxQeQ+ZH2YqTsZwY3+?=
 =?us-ascii?Q?W384w6csz1oU0Kss9qK1B1CWKCyfGTxie8AlNgQMG3sOhlJJ1vbdBcOKV4H7?=
 =?us-ascii?Q?gzXGnNbkmiwT/zsDx3O/N/zI87c8bbavQv0MJRgXdQ6Cv9S0kl6bWK5IyBiq?=
 =?us-ascii?Q?SAZVr4zo+T/bMXcdPUWrtdteIFme++v2AlNcV938y4ZJGj2R9HXbJIyo85AG?=
 =?us-ascii?Q?P/7zapGSKMW0s64mc9RPyIs775r66c2WV5znhlW7YdeZw9GYU/P0PbvUQTwV?=
 =?us-ascii?Q?3NMXYT2vCRkNKQ0vbZaFrnTHv5amd5rEFER2/X7Cblc5GqoRtWympUrqEsFn?=
 =?us-ascii?Q?6zlxDJ+jQRHsRdseL6JR0xolKlJgWcGzoVYYmz4zqoJUiH9q1ZCCJqXZcNoO?=
 =?us-ascii?Q?ndggj4IK2qK2uP9CInSo5J9JzTe+lGTrGZAZCThcdu+7X9PAyKz4AePAzUZJ?=
 =?us-ascii?Q?84A5EG11iXaQp9y8rOISxhmfuwsZkCXiqipbSwSSoz8YKLwy9vBnqztm0VtH?=
 =?us-ascii?Q?j0Z2mHP8Q6z2PyAC7YY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d768a55-a864-4e66-27ab-08dd1025e181
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 03:28:23.9625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /guXa2eVV/fYe6lld2r4E211cOq3zyPM9FcBlkwsEdSKttUErjwbTwtLPNK0m3ZFNIx+vi5BJZpdiKU5ucT27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jinzhou=
 Su
>Sent: Friday, November 29, 2024 10:30 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lin, Wayne
><Wayne.Lin@amd.com>; Strauss, Andrew <Andrew.Strauss@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Lin, Wayne
><Wayne.Lin@amd.com>
>Subject: [PATCH] drm/amdgpu: Add secure display v2 command
>
>Add secure display v2 command to support multiple ROI instances per displa=
y.
>
>v2: fix typo and coding style issue
>
>Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
>Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
> .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 25 +++++++++++++++++--
> 2 files changed, 25 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index f015961f257a..12832fd834fb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -2264,7 +2264,8 @@ int psp_securedisplay_invoke(struct psp_context *psp=
,
>uint32_t ta_cmd_id)
>               return -EINVAL;
>
>       if (ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__QUERY_TA &&
>-          ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
>+          ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC &&
>+          ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2)
>               return -EINVAL;
>
>       ret =3D psp_ta_invoke(psp, ta_cmd_id, &psp->securedisplay_context.c=
ontext);
>diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>index 00d8bdb8254f..926da6d46322 100644
>--- a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>+++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
>@@ -31,10 +31,12 @@
>  *    Secure Display Command ID
>  */
> enum ta_securedisplay_command {
>-      /* Query whether TA is responding used only for validation purpose =
*/
>+      /* Query whether TA is responding. It is used only for validation
>+purpose */
>       TA_SECUREDISPLAY_COMMAND__QUERY_TA              =3D 1,
>       /* Send region of Interest and CRC value to I2C */
>       TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC          =3D 2,
>+      /* V2 to send multiple regions of Interest and CRC value to I2C */
>+      TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2       =3D 3,
>       /* Maximum Command ID */
>       TA_SECUREDISPLAY_COMMAND__MAX_ID                =3D 0x7FFFFFFF,
> };
>@@ -83,6 +85,8 @@ enum ta_securedisplay_ta_query_cmd_ret {  enum
>ta_securedisplay_buffer_size {
>       /* 15 bytes =3D 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) */
>       TA_SECUREDISPLAY_I2C_BUFFER_SIZE                =3D 15,
>+      /* 16 bytes =3D 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) + 1 byt=
e(roi_idx) */
>+      TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE             =3D 16,
> };
>
> /** Input/output structures for Secure Display commands */ @@ -95,7 +99,1=
5 @@
>enum ta_securedisplay_buffer_size {
>  *    Physical ID to determine which DIO scratch register should be used =
to get ROI
>  */
> struct ta_securedisplay_send_roi_crc_input {
>-      uint32_t  phy_id;  /* Physical ID */
>+      /* Physical ID */
>+      uint32_t  phy_id;
>+};
>+
>+struct ta_securedisplay_send_roi_crc_v2_input {
>+      /* Physical ID */
>+      uint32_t phy_id;
>+      /* Region of interest index */
>+      uint8_t  roi_idx;
> };
>
> /** @union ta_securedisplay_cmd_input
>@@ -104,6 +116,9 @@ struct ta_securedisplay_send_roi_crc_input {  union
>ta_securedisplay_cmd_input {
>       /* send ROI and CRC input buffer format */
>       struct ta_securedisplay_send_roi_crc_input        send_roi_crc;
>+      /* send ROI and CRC input buffer format, v2 adds a ROI index */
>+      struct ta_securedisplay_send_roi_crc_v2_input     send_roi_crc_v2;
>+      /* Reserved space for future expansion */

The comment "/* Reserved space for future expansion */" is misleading here.

Get this fixed, the patch is

Reviewed-by: Lang Yu <lang.yu@amd.com>


>       uint32_t                                          reserved[4];
> };
>
>@@ -128,6 +143,10 @@ struct ta_securedisplay_send_roi_crc_output {
>       uint8_t  reserved;
> };
>
>+struct ta_securedisplay_send_roi_crc_v2_output {
>+      uint8_t  i2c_buf[TA_SECUREDISPLAY_V2_I2C_BUFFER_SIZE];  /* I2C buff=
er
>+*/ };
>+
> /** @union ta_securedisplay_cmd_output
>  *    Output buffer
>  */
>@@ -136,6 +155,8 @@ union ta_securedisplay_cmd_output {
>       struct ta_securedisplay_query_ta_output            query_ta;
>       /* Send ROI CRC output buffer format used only for validation purpo=
se */
>       struct ta_securedisplay_send_roi_crc_output        send_roi_crc;
>+      /* Send ROI CRC output buffer format used only for validation purpo=
se */
>+      struct ta_securedisplay_send_roi_crc_v2_output     send_roi_crc_v2;
>       uint32_t                                           reserved[4];
> };
>
>--
>2.43.0

