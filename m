From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/6] drm/dp_mst: Introduce
 drm_dp_mst_connector_atomic_check()
Date: Thu, 20 Sep 2018 12:16:31 +0300
Message-ID: <20180920091631.dyxytd7zecbpmv64@mwanda>
References: <20180918230637.20700-2-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
In-Reply-To: <20180918230637.20700-2-lyude@redhat.com>
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, kbuild-all@01.org, stable@vger.kernel.org, Sean Paul <sean@poorly.run>
List-Id: amd-gfx.lists.freedesktop.org

Hi Lyude,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Lyude-Paul/Fix-legacy-DPMS-changes-with-MST/20180919-203434
base:   git://anongit.freedesktop.org/drm-intel for-linux-next

smatch warnings:
drivers/gpu/drm/drm_dp_mst_topology.c:3144 drm_dp_mst_connector_still_exists() error: we previously assumed 'port' could be null (see line 3146)

# https://github.com/0day-ci/linux/commit/f8df31d5221b9a6da6698d4a37e622253bb17cdc
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f8df31d5221b9a6da6698d4a37e622253bb17cdc
vim +/port +3144 drivers/gpu/drm/drm_dp_mst_topology.c

3f3353b7 Pandiyan, Dhinakaran 2017-04-20  3131  
f8df31d5 Lyude Paul           2018-09-18  3132  static bool
f8df31d5 Lyude Paul           2018-09-18  3133  drm_dp_mst_connector_still_exists(struct drm_connector *connector,
f8df31d5 Lyude Paul           2018-09-18  3134  				  struct drm_dp_mst_topology_mgr *mgr,
f8df31d5 Lyude Paul           2018-09-18  3135  				  struct drm_dp_mst_branch *mstb)
f8df31d5 Lyude Paul           2018-09-18  3136  {
f8df31d5 Lyude Paul           2018-09-18  3137  	struct drm_dp_mst_port *port;
f8df31d5 Lyude Paul           2018-09-18  3138  	bool exists = false;
f8df31d5 Lyude Paul           2018-09-18  3139  
f8df31d5 Lyude Paul           2018-09-18  3140  	mstb = drm_dp_get_validated_mstb_ref(mgr, mstb);
f8df31d5 Lyude Paul           2018-09-18  3141  	if (!mstb)
f8df31d5 Lyude Paul           2018-09-18  3142  		return false;
f8df31d5 Lyude Paul           2018-09-18  3143  
f8df31d5 Lyude Paul           2018-09-18 @3144  	list_for_each_entry(port, &mstb->ports, next) {
                                                                            ^^^^
We need to use a different loop iterator, or possibly
list_for_each_entry_safe() because it looks like we're freeing
something.  Maybe it's cleanest to do both.

f8df31d5 Lyude Paul           2018-09-18  3145  		port = drm_dp_get_validated_port_ref(mgr, port);
f8df31d5 Lyude Paul           2018-09-18 @3146  		if (!port)
f8df31d5 Lyude Paul           2018-09-18  3147  			continue;
f8df31d5 Lyude Paul           2018-09-18  3148  
f8df31d5 Lyude Paul           2018-09-18  3149  		exists = (port->connector == connector ||
f8df31d5 Lyude Paul           2018-09-18  3150  			  (port->mstb &&
f8df31d5 Lyude Paul           2018-09-18  3151  			   drm_dp_mst_connector_still_exists(connector, mgr,
f8df31d5 Lyude Paul           2018-09-18  3152  							     port->mstb)));
f8df31d5 Lyude Paul           2018-09-18  3153  
f8df31d5 Lyude Paul           2018-09-18  3154  		drm_dp_put_port(port);
f8df31d5 Lyude Paul           2018-09-18  3155  		if (exists)
f8df31d5 Lyude Paul           2018-09-18  3156  			break;
f8df31d5 Lyude Paul           2018-09-18  3157  	}
f8df31d5 Lyude Paul           2018-09-18  3158  
f8df31d5 Lyude Paul           2018-09-18  3159  	drm_dp_put_mst_branch_device(mstb);
f8df31d5 Lyude Paul           2018-09-18  3160  	return exists;
f8df31d5 Lyude Paul           2018-09-18  3161  }
f8df31d5 Lyude Paul           2018-09-18  3162  
