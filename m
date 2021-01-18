Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEE9C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741FA206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 08:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741FA206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03D936E17C;
	Mon, 18 Jan 2021 08:42:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F36D6E17C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 08:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kptf8ZKVSqJgTJZTduyaY1szv7GJtFo2vP6i5w6OfuwrO3t1eQQmuhvDNFOAlYQXi2Zh+ezAkNX3x+tjMpK4B8HWXfajJtv6V6lO3l+kNsnEXSnKDxZyLyWDbuA/8Tg6nZyuHjMWkZMa2OOvLt6kc6ia5+/7Wc0XrlrbqQwlPd1L8YXZq0bA1TdRvRvywhFuM3xYCdho6r6m4b1s1XMMORk1m2EFnf6fZP4KD1LWeo5Wm+qZL8Za0pOiDEC00A4xLdK64kheMK3H/t5ECwi0Z1joxImFzh4c/sH6RYrJqvnoCstx9+FEupdQnQcGIpv7SD03W0R9zZVmtwtIsv+6VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6bXU7NCOS+nRcjbLnAETNBpYJnSXapPKavpmvef9v8=;
 b=aigucbVzLWLNxgULjeJmO9Nlg2D0x+h/7qLe/5iNcJF548DVKawV9saJznYZzkyTFLBL3kEVvKuporj5w4SP2Qn2L8Be+PwrZPMQu0YvLUZObNQgEU3o1Z3WzXdZN7psVWqsWo/Fko69EB4kECDuH0a8dNsUQwoKoteUDknZP0WPMTpNpIhwjcQb4LlUsMEWidlsbaa/7m79x4k3KPjuxOX3l0HQ1TdBr5hYRJJq4FZUl2XLGepVZZz9ThcUXaZjM311ups+fAHc/+QOHt+4Huo7qKsVKGs9sQoWLOU3q/0Lm1Kr7qzeYU5MYXjhE+64Ya6uW0z7E9HL3bZ3HuU16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6bXU7NCOS+nRcjbLnAETNBpYJnSXapPKavpmvef9v8=;
 b=0kgGUnPRZ1OTCzyDG5Uw4UEjOUR9PyK2zUHL4zWGErLoENpZ/0xckRv/1ynjv0hDcdstto8QwqoRghk6b1MrQf5f6bYZM6J/ELI5cqrNCw+QJKsQHViPUwUugBfjnaOAY4rVC73j+h/H2qqpYXvt1O0l4ZtM6Khc54PfZAxfB2E=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 08:42:07 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::44aa:dfd4:9:1590]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::44aa:dfd4:9:1590%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 08:42:06 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: remove redundant flush_delayed_work
Thread-Topic: [PATCH] drm/amd/amdgpu: remove redundant flush_delayed_work
Thread-Index: AQHW7URThM6QWyaj00ybQubSujpdL6otEPkg
Date: Mon, 18 Jan 2021 08:42:06 +0000
Message-ID: <DM5PR12MB1708A200B0CCA69F10803D6B84A40@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20210118024714.2730735-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210118024714.2730735-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-18T08:42:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19878103-f195-4409-9df4-21a647ccafe4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2704e92-eb1e-44c6-9a1f-08d8bb8ceffd
x-ms-traffictypediagnostic: DM6PR12MB2618:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2618BB4826CD2780AEC366ED84A40@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g5IHNOzWPfLofnmz8dIZ11X9/USVDRiL5NGb/rIYR1Tlj2gcxYR/pEaB+KxPjeItXpU9IuvrcsFi2Wf7UTVF6aZJlXdtqd4c/28S4iGySlW/eXf8fEJdqyFjoilnEk07Nrcs5jqf1kFLZmOSVyuUtiGWA6lts3RNfkgFLogCoRkqTmp4obPbMzKV28akT9OLTHnPkuwUDlqRDVPhGAdnknMp6FOSIZAeQ7I39ibxH/C6vKNJJtthKTKgry70pLvXAxKzIttSIR8FUlsp+hkrmFbwKLgm2hQOTrIYlzjZexMSzFfKnryuKp43mEbt4H2SiJqjKgy1WQdLoichVe+OHdis7u7uX+iP9Zog0J7RLNE9oogp4q5ZMs0OISFqJcBnaq7gU/l5THS8myvJQk81LRUszVDt08GXa9PFtDNTiCg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(8676002)(110136005)(7696005)(316002)(86362001)(4326008)(64756008)(33656002)(66556008)(66446008)(66476007)(6506007)(966005)(52536014)(55016002)(9686003)(478600001)(53546011)(45080400002)(2906002)(8936002)(5660300002)(76116006)(186003)(26005)(71200400001)(66946007)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e/+p1df3I80Bma1+YazKR4WMdMYj4dZg0yjPIHuE2yxiioypJd3LmB32uZ2u?=
 =?us-ascii?Q?d8NfWOwo29Fyl0gjU4iH4Ah+E39CgWncqM2Le08Vy7SMaO643nQseeb1Rs/z?=
 =?us-ascii?Q?mU4mtrUrPr96jGNDu4+7392FgHcoV7D3QAA3hsSRPg12KivVQqgThuyAkViw?=
 =?us-ascii?Q?s2KJ1cVgKJrXbqgnGqlFJ5r1TuJM+f5NXM3MEEZV7YeKahsD9GQqB+G8ooSh?=
 =?us-ascii?Q?++L/efEVYkzvp25r+P26AfIwUrrbuTAwjTgY9kAuPyqIy9d8M2axyHx7pbl3?=
 =?us-ascii?Q?x1q8lldwwKFXsZp8sglM3Nvm29UsVoPkmwZdAd+/PwKWczdrAxuJ0u3qMuKT?=
 =?us-ascii?Q?0FiN9BRZy7WLeev5PN6QiUyOE7HdONTnMwTRZvHxSCW8L7Ux6R3mLnEId3Le?=
 =?us-ascii?Q?vi4VSDPhSK9PIgMknMwtuOzB6ju5E4U4zqNc/oiVE97FHqLoTVbEat58v4iv?=
 =?us-ascii?Q?+ZeUXJ1wK3XOKWYViOoYSJI5hLbvC6+x3oMamDlVsFlUdlaejVobiQSEM875?=
 =?us-ascii?Q?ed8PPRje6VuS1zB5Cm7QrfV4nLZj05Q74HSPR6oKd8gnMEwYx7htMrymh+AL?=
 =?us-ascii?Q?MALNmIMmNspBCNkxeqwZoiy5IqTABBNFE6PHu0wEI0CSdw6EMd5RtxVggjVF?=
 =?us-ascii?Q?+/eucN/Rl7K9NWOocZbShOOWax3VMR6DEJhgJbxLaS4W6+7lx57XCIWtp1nc?=
 =?us-ascii?Q?M6FD4syJI7SyScuNsEQpLSjjf+O8OzY1xNY/Ob3LrftwkyOyLvYSJKo4kq8X?=
 =?us-ascii?Q?vZzFGXF5yGudwwSCL9muEIVd0JTk3q5EzIEw5eP+LS6ZpurL4eP+4yjF/CeH?=
 =?us-ascii?Q?NJWKUFvfsR1F0KsXcBrhOMrEO0cmA4m0lMuh7Br5oLt5fPAp+CtI8s/3V+v9?=
 =?us-ascii?Q?9EajWw8eXrPKQsb9LsKWwsrvIzf7QtUydBZ2eWqdC4YBexOox14IRdA/N8Pn?=
 =?us-ascii?Q?C19B+uUcuS1D/PlU87KfhV86RfBVrwondyPhpu2dYhwRUUyDq97/buhXTAwn?=
 =?us-ascii?Q?86dW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2704e92-eb1e-44c6-9a1f-08d8bb8ceffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 08:42:06.8155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tI8bP928+DrXcmRk9xIXn5ab+8k+3in/r3rpyVvLrpBFWl95QJkpz9Y3m9AjWEmp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jingwen Chen
Sent: Monday, January 18, 2021 10:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu: remove redundant flush_delayed_work

When using cancel_delayed_work_sync, there's no need to flush_delayed_work first. This sequence can lead to a redundant loop of work executing.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3e212862cf5d..c649944e49da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -569,7 +569,6 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)  {
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
 		DRM_INFO("clean up the vf2pf work item\n");
-		flush_delayed_work(&adev->virt.vf2pf_work);
 		cancel_delayed_work_sync(&adev->virt.vf2pf_work);
 		adev->virt.vf2pf_update_interval_ms = 0;
 	}
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmonk.liu%40amd.com%7C959a668e79e44b56af7708d8bb5b7457%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637465348766384167%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=zr9WvU7%2B%2B3cx9O2Vb8nIFYa9PZAT7bFOkdecY%2FLXdMI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
