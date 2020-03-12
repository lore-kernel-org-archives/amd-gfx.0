Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B5DC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 09:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6B92067C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 09:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHUqE87S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6B92067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FAB6E106;
	Thu, 12 Mar 2020 09:18:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2220C6E106
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 09:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfMqDzQMnYcxP4kFsPQ8cntRjEt9+91RGxWAluZc/3dYHowJi3KCyv7o1l/9T1kiaUGvgjcNqcKkbKx/t0em56MK53I/eL5sDuAKl7L4ABh2OcLcOUPrORy4iEH/9jhZHqn5DP+yVWgSJ9Q0WRV4fhvg2caPGsx4XuOasrks4rwqQY4388WqAovbbT6GV0/N9mdkIUjPpmIrw9IuQx+Tv7+sxFfUZPbFBTrkbkbSGYfVq97GJck8Wcm/OLQKIBFdXh8Or4Jzlv/YoJOae0ZkKpGm6MyqnwUYJEjikEC2ZQ5XcD4/0RPgeKUYX7/s+pw1Hn4vCP2TpMKydBNpVJuqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfZ2zxWkQ6MqN47b2YEndcNMMZZ06eO7X9VaVtd5WVQ=;
 b=PCzUIqNOyhhHeSVJOK5KIe4d0qedSJBoInrYyBxMprZms2kWssxWsiF5v92nYT/4p5neyD95JyhHXH4ng2DvtmRnB5VpSTJl42rhQTs4Ip/l0LHMRLNjur5Hing5lE3kvFTpgiyUBwSEdtnCgFcDsyXTaRWpdyNYqJw7yV9zMapKeUfdgF9HFK/q/ZBjhOONPWLlQJZJm8ncUA+KybFf+J6IOu9OOjuSnQuyOUGvAkuKSyn3QBSgXvxHMObSS/rpV4fNyTjQk18j0ch3tFiErjL0jVPoOFf6ev2UVDxOEXcZJvcN8sLe310JAvO5fcgE3wxKiMwogDffE8roiUjvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfZ2zxWkQ6MqN47b2YEndcNMMZZ06eO7X9VaVtd5WVQ=;
 b=xHUqE87SHsdo6ArFUE5DNMIqwBeuJIqB+XUGnleVd8nRZDk/a+vIdO8IyN5cKqJWNK8VINaEpfNZMxROJoF6q7VWCTTsxD9YIJoO9ktb8LnH0oO/75Z/4xgCArUDgokLlOJKxGm92DtzZLoa1fko9L9vlguHqNllqOYLZ7M3Ipg=
Received: from MWHPR12MB1837.namprd12.prod.outlook.com (2603:10b6:300:113::20)
 by MWHPR12MB1615.namprd12.prod.outlook.com (2603:10b6:301:10::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Thu, 12 Mar
 2020 09:18:22 +0000
Received: from MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::84e2:7919:afcd:a928]) by MWHPR12MB1837.namprd12.prod.outlook.com
 ([fe80::84e2:7919:afcd:a928%10]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 09:18:22 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [bug report] drm/amdgpu: add function to creat all ras debugfs
 node
Thread-Topic: [bug report] drm/amdgpu: add function to creat all ras debugfs
 node
Thread-Index: AQHV+EDHXj1WhY3+Zkmt7FhqF3LCtqhErU7w
Date: Thu, 12 Mar 2020 09:18:21 +0000
Message-ID: <MWHPR12MB1837058CB50BB7B8E06AD4B09AFD0@MWHPR12MB1837.namprd12.prod.outlook.com>
References: <20200312073351.GA29451@mwanda>
In-Reply-To: <20200312073351.GA29451@mwanda>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-12T09:18:19Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fdc83c35-e44e-4ebf-b7e4-0000cedf2f95;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-12T09:18:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4dc79206-3de6-45a9-af0b-0000e0d56703
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanley.Yang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cf327f2-71e1-4631-912c-08d7c6664fab
x-ms-traffictypediagnostic: MWHPR12MB1615:|MWHPR12MB1615:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB161567446C717CF3DEF6818F9AFD0@MWHPR12MB1615.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(4326008)(8676002)(8936002)(316002)(86362001)(55016002)(33656002)(66446008)(66556008)(9686003)(64756008)(66476007)(52536014)(2906002)(5660300002)(26005)(478600001)(66946007)(966005)(71200400001)(45080400002)(76116006)(81156014)(6506007)(6636002)(7696005)(53546011)(110136005)(81166006)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1615;
 H:MWHPR12MB1837.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pljfp7Z8Uc/bk+XQD7TFJTH2+jvWWKbwFwZ/8zBVlNV7B/iBd75H8N0jO48zJgIwrT3d/m4HAKKg4AGgmIljIpPdxno0dx53G6eCI4d7lBeuJOdD+rZNTpIu7o07FTmQsbhtOq/3O5GEmi4XkMBf3NYdSxXiJiC57wbrTUqbhAInUA4NSQkhCUJWHzJUIXP4bWT+Jksz8DB52TQo0RucLXMhWxLjqkubACVS4UUSNyQOs4east3RXV5/nC0k9hHngp3dwVyUYNdWoSMVqMSa8lque3DU+VzISL82RzsNOr7Hk3eXl8sxg1YdclA04HXrQC49zb+z6Dz/kkLg0hOAk7Apa0krI5BxgvNhhzmkVNs1Du9DDuP2JESGUN1/vLicBP62dbXGgd4rjj0sR4ou0G01aX70TY0rWKO6irSiBFMX/ziEmiBK0BP4VPqIJ0Q4f9YFgPZwjWxvCp+uO4N+pY/QpLHBhcP/8jFrifscLY=
x-ms-exchange-antispam-messagedata: GabQXgXyv+7ESYlvAbxhgMDKwA1n5pi51Z8MsQseREm++7IMUv039yehapSKjqOptoLXUaPkpbNMOaNzO0d+Ue75sAeG5e4/Fj26bOL9PJodOIF19A7Es7rMdaBGLCLytxi8h4w4ta4zL4ABeUVfJw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf327f2-71e1-4631-912c-08d7c6664fab
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 09:18:21.9763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AesIdw0/MuhGtGnnmCXP7IW/2yejJ/C/S8PIoDZI0KdDC6+xuJGYRuVoVnTsDSVda1BZsxy67PvleSAVMyZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1615
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Carpenter,

Thanks for your report and advice, I will update the code.

Regards,
Stanley

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dan Carpenter
Sent: Thursday, March 12, 2020 3:34 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amdgpu: add function to creat all ras debugfs node

Hello Tao Zhou,

The patch f9317014ea51: "drm/amdgpu: add function to creat all ras debugfs node" from Mar 6, 2020, leads to the following static checker
warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1132 amdgpu_ras_debugfs_create_all()
	warn: variable dereferenced before check 'obj' (see line 1131)

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
  1116  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
  1117  {
  1118          struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
  1119          struct ras_manager *obj, *tmp;
  1120          struct ras_fs_if fs_info;
  1121  
  1122          /*
  1123           * it won't be called in resume path, no need to check
  1124           * suspend and gpu reset status
  1125           */
  1126          if (!con)
  1127                  return;
  1128  
  1129          amdgpu_ras_debugfs_create_ctrl_node(adev);
  1130  
  1131          list_for_each_entry_safe(obj, tmp, &con->head, node) {
  1132                  if (!obj)
                            ^^^^
There is no need to check for NULL here, so just remove the check.  The other question is why is this using list_for_each_entry_safe() instead of vanilla list_for_each_entry()?  It doesn't seem to be freeing "obj"
or removing "obj" from the list which are basically the only reasons why _safe() is used.  Some people think _safe() has something to do with locking but it doesn't.

Please remove the test and use vanilla list_for_each_entry().

  1133                          continue;
  1134  
  1135                  if (amdgpu_ras_is_supported(adev, obj->head.block) &&
  1136                          (obj->attr_inuse == 1)) {
  1137                          sprintf(fs_info.debugfs_name, "%s_err_inject",
  1138                                          ras_block_str(obj->head.block));
  1139                          fs_info.head = obj->head;
  1140                          amdgpu_ras_debugfs_create(adev, &fs_info);
  1141                  }
  1142          }
  1143  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CStanley.Yang%40amd.com%7C53ba68a9a148488cc80208d7c657bce8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637195953186661183&amp;sdata=d8nkKXcNy6Jyg3SyTdlUpe%2B28WsltOmkCMbeNPXksCg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
